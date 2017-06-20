# kurator-SPNHC17-YW

Demonstration of prospective and retrospective provenance queries on a YesWorkflow marked up Kurator workflow for SPNHC 2017

## Prerequisites

Installation of YesWorkflow jar (in {project_root}/yw_jar

Obtain 

yesworkflow-0.2.2.0-SNAPSHOT-jar-with-dependencies.jar.gz

from https://github.com/yesworkflow-org/yw-prototypes/releases/tag/0.2.2.0-alpha

Install xsb

Set the path to the xsb binary in settings.sh

e.g.

export XSB="/usr/local/bin/xsb/xsb-3.7/bin/xsb"

Checkout kurator-validation

make symbolic links 

target

packages 

into the kurator-validation checkout

## To run

source settings.sh
sh make.sh

or run the commands in make.sh individually.
