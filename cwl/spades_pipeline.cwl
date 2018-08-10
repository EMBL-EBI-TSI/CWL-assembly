class: Workflow
cwlVersion: v1.0

requirements:
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}

inputs:
  forward_reads:
    type: File
  reverse_reads:
    type: File
  output_dest:
    type: string
    default: 'stats_report.json'
  min_contig_length:
    type: int

outputs:
  assembly:
    outputSource: spades/contigs
    type: File
  assembly_log:
    outputSource: spades/log
    type: File
  assembly_params:
    outputSource: spades/params
    type: File
  assembly_scaffolds:
    outputSource: spades/scaffolds
    type: File
  samtools_index:
    outputSource: stats_report/samtools_index_output
    type: File
  coverage_tab:
    outputSource: stats_report/metabat_coverage_output
    type: File
  logfile:
    outputSource: stats_report/logfile
    type: File

steps:
  spades:
    in:
      forward_reads:
        source: forward_reads
      reverse_reads:
        source: reverse_reads
    out:
      - assembly_graph
      - contigs
      - contigs_assembly_graph
      - contigs_before_rr
      - internal_config
      - internal_dataset
      - log
      - params
      - scaffolds
      - scaffolds_assembly_graph
    run: assembly/spades.cwl
    label: 'spades: de novo metagenomics assembler'
  stats_report:
    in:
      sequences:
        source: spades/contigs
      reads:
        source: [forward_reads, reverse_reads]
      output_dest:
        source: output_dest
      min_contig_length:
        source: min_contig_length
    out:
      - bwa_index_output
      - bwa_mem_output
      - samtools_view_output
      - samtools_sort_output
      - samtools_index_output
      - metabat_coverage_output
      - logfile
    run: stats/stats.cwl

$schemas:
  - 'http://edamontology.org/EDAM_1.16.owl'
  - 'https://schema.org/docs/schema_org_rdfa.html'

$namespaces:
  edam: 'http://edamontology.org/'
  iana: 'https://www.iana.org/assignments/media-types/'
  s: 'http://schema.org/'

's:copyrightHolder': EMBL - European Bioinformatics Institute
's:license': 'https://www.apache.org/licenses/LICENSE-2.0'

# export TMP=$PWD/tmp; cwltoil --user-space-docker-cmd=docker --debug --outdir $PWD/out --logFile $PWD/log  --workDir $PWD/tmp_toil --retryCount 0 cwl/spades_pipeline.cwl cwl/spades_pipeline.yml