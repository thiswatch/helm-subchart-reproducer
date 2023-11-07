# Helm Subchart conditional not working - Reproducer

## TL;DR

Conditionals of a Subchart are not evaluated correctly.

```shell
cd wrapper-chart
helm template . | wc -l
```

should not be `11.497` lines! Conditionals don't seem to be taken into account at all.

Compared this to the template with default values (note that mayastor is disabled in the default chart es well)

```shell
cd wrapper-chart/charts/openebs
helm template . | wc -l
```

you will get `457` lines of yaml.

## Details

In `wrapper-chart` there is a parent Helm chart used to wrap the OpenEBS chart.

Since OpenEBS relies on Subcharts with conditions like

```yaml
- condition: mayastor.enabled
  name: mayastor
  repository: https://openebs.github.io/mayastor-extensions
  version: 2.4.0
```

we assume you should be able to set those via values.yaml. We therefore have deactivated `mayastor` for example with:

```yaml
openebs:
  mayastor:
    enabled: false
```

This does not work! When running

```shell
helm template . > output.yaml
```

you will have a 11k+ lines yaml file.

In which scope are conditionals evaluated?
