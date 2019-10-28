# Dataflow side inputs vs. BigQuery

One of the Data Engineering course labs is [JavaProjectsThatNeedHelp.java](https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/data_analysis/lab2/javahelp/src/main/java/com/google/cloud/training/dataanalyst/javahelp/JavaProjectsThatNeedHelp.java),
which uses Dataflow to parse github Java commits from BQ and compute a composite score for each Java package found in these commits.

Because the data is coming from BigQuery in the first place,
the same results can be obtained much more quickly in BQ because the data never has to leave BQ. The following SQL code,
courtesy of [Stephan Meyn](https://github.com/smeyn), achieves the exact same results, but much faster. In addition, the getPackages() method courtesy of Alex Lamana uses some very clever SQL with UNNEST to emit one row for each level of the package name.

* Dataflow python: 13 min
* Dataflow Java: 10 min
* BigQuery: 10 sec

```sql
#StandardSQL

# JavaProjectsThatNeedHelp.sql
# Authors: Stephan Meyn, Alex Lamana

# take a package and break it into subpackages
# e.g.
# com.google.package.subpackage is turned into an array of:
# com
# com.google
# com.google.package
# com.google.package.subpackage
CREATE TEMP FUNCTION getPackages(input STRING, delimiter STRING) AS (
  (SELECT ARRAY_AGG(prefix)
   FROM (
    SELECT ARRAY_TO_STRING(
      ARRAY_AGG(value) OVER(ORDER BY i ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
      delimiter) prefix
    FROM UNNEST(SPLIT(input, delimiter)) value WITH OFFSET i
    )
  )
);
# Extract the package statements, all import statenments and FIXME/TODO statements
with baseImport as (
  SELECT REGEXP_EXTRACT(content, "\\s*package (.+);") as package ,
  REGEXP_EXTRACT_ALL(content, "\\s*import (.+);") as importedpackage
  ,REGEXP_EXTRACT_ALL(content, "FIXME|TODO") as needhelp
  FROM `fh-bigquery.github_extracts.contents_java_2016` ),
  
# for needhelp organise the packages and the nr of help needed stmts  
packagesWithHelp as (
  select getPackages(package, ".") as packageList, 
  array_length(needhelp) as numHelp
  from BaseImport where package is not null),

# flatten into multiple records, one per package, and aggregate over package  
needsHelp as (
   select flattenedPackage as package, sum(numhelp) as numhelp
   from packagesWithHelp
   CROSS JOIN UNNEST(packagesWithHelp.packageList) as flattenedPackage
   group by package),

# get all imports, split them up as well and flatten the imported packages   
Imports as (
  SELECT package, getPackages(flattenedImports, ".")  as importedpackages
  from BaseImport
  CROSS JOIN UNNEST(BaseImport.importedpackage) as flattenedImports),

# flatten the imported packages as well and count how many times a package is imported  
package_use as (
  SELECT imported, count(*) as numtimesUsed
  from imports
  CROSS JOIN UNNEST(imports.importedpackages) as imported
  group by imported
),

# join imported stats with help needed stats and calculate a score
final as (   
  select 
    package_use.imported as package, 
    package_use.numTimesUsed,
     numhelp, 
     needsHelp.package as nPackage,
     LOG(package_use.numTimesUsed) * log(numhelp) as score
  from package_use 
  join  needsHelp on needsHelp.package = package_use.imported
  and numhelp > 0)
  
select * from final 
order by score desc
```
