![image](pics/bioinflow_logo.png)

A Nextflow pipeline for providing public health bioinfo

#### Introduction



#### Quick-start

```
nextflow run BCCDC-PHL/bioinflow -profile conda \
  --fasta_dir /path/to/fasta_directory \
  --model_R1 /path/to/error_model_R1 \
  --model_R2 /path/to/error_model_R2 \
  --outdir /path/to/outputs 
```


#### Installation
An up-to-date version of Nextflow is required because the pipeline is written in DSL2. Follow the instructions at https://www.nextflow.io/ to download and install Nextflow.


#### Conda
The repo contains a environment.yml files which automatically build the correct conda env if `-profile conda` is specifed in the command. 

--cache /some/dir can be specified to have a fixed, shared location to store the conda build for use by multiple runs of the workflow.

#### Config

Important config options are:

| Option                           | Default  | Description                                                                                                         |
|:---------------------------------|---------:|--------------------------------------------------------------------------------------------------------------------:|
| `vary_amplicon_depths`       | `false`    | Set to true if user is supplying individual amplicon depths                                                         |
| `amplicon_depths`          | `NO_FILE`      | A CSV file containing "amplicon" and "depth" for each amplicon in primer.bed file                                                      |
| `depth`                        | `50`     | Desired depth for reads if not supplying individual amplicon depths                                                                       |
| `fragment_mean`                  | `600`     | Mean genomic fragment size                                            |
| `fragment_sd`            | `75`   | Standard deviation of genomic fragment size                                                                    |
| `read_length`               | `150`   | Simulated read length                                                                 |
| `model_R1`                    | `NO_FILE`     | Error profile of R1 reads                                                                              |
| `model_R2`                    | `NO_FILE`     | Error profile of R2 reads                                                                              |

#### Output
A subdirectory for each process in the workflow is created in `--outdir`. 




