#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerImageId: coverage_report
    dockerFile:
      $include: coverage_report/Dockerfile
  InlineJavascriptRequirement: {}

baseCommand: ['python', '/coverage_report.py']

inputs:
  base_count:
    type: int
    inputBinding:
      position: 2
  sequences:
    type: File
    inputBinding:
      position: 3
  coverage_file:
    type: File
    inputBinding:
      position: 4
  output:
    type: string
    inputBinding:
      position: 5

outputs:
  logfile:
    type: File
    outputBinding:
      glob: $(inputs.output)

doc: |
  usage: coverage_report.py [-h] output coverage_file base_count

  Script to calculate coverage from coverage.tab file and output report

  positional arguments:
    output         Output file
    coverage_file  Coverage.tab file
    base_count     Sum of base count for all input files

  optional arguments:
    -h, --help     show this help message and exit


