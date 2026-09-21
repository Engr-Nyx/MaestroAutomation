# Run Maestro flows locally and open an Allure report.
# Requires: Maestro, Java 17+, and `npm i -g allure-commandline`
param([string]$Tags = "")

Remove-Item -Recurse -Force allure-results, allure-report -ErrorAction SilentlyContinue
New-Item -ItemType Directory allure-results | Out-Null

$args = @("test", "flows/", "--format", "junit", "--output", "allure-results/maestro-junit.xml")
if ($Tags) { $args += "--include-tags=$Tags" }
maestro @args

allure generate allure-results --clean -o allure-report
allure open allure-report
