#!/usr/bin/env bash

# set variables
source settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

# export YW model and extract facts
$YW_CMD graph
# $YW_CMD model $WORKFLOWS_DIR/file_branching_taxon_lookup.yaml \
#         -c extract.language=bash \
# 		  -c extract.listfile=listing.txt \
#         -c extract.factsfile=$FACTS_DIR/yw_extract_facts.P \
#         -c model.factsfile=$FACTS_DIR/yw_model_facts.P \
#         -c query.engine=xsb

# materialize views of YW facts
$QUERIES_DIR/materialize_yw_views.sh > $VIEWS_DIR/yw_views.P

# run the workflow
java -jar target/kurator-validation-1.0.1-SNAPSHOT-jar-with-dependencies.jar -f packages/kurator_branching/workflows/file_branching_taxon_lookup.yaml -p inputfile=packages/kurator_branching/data/kurator_sample_data.txt -l ALL > runlog.log 2>&1

# generate reconfacts.P to facts/ folder 

# cd packages/kurator_branching/workflows/
# java -jar ../../../yw_jar/yesworkflow-0.2.2.0-alpha-jar-with-dependencies.jar recon file_branching_taxon_lookup.yaml \
#         -c extract.language=bash \
#         -c recon.factsfile=facts/reconfacts.P \
#         -c query.engine=xsb
# cd ../../../
$YW_CMD recon
# draw complete workflow graph with URI template
$YW_CMD graph $WORKFLOWS_DIR/file_branching_taxon_lookup.yaml \
		-c extract.language=bash \
        -c graph.view=combined \
        -c graph.layout=tb \
        > $RESULTS_DIR/complete_wf_graph_uri.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.svg


# draw complete workflow graph
$QUERIES_DIR/render_complete_wf_graph.sh > $RESULTS_DIR/complete_wf_graph.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.svg

# list workflow outputs
$QUERIES_DIR/list_workflow_outputs.sh > $RESULTS_DIR/workflow_outputs.txt


##############
#   Q1_pro   #
##############

# draw worfklow graph upstream of OutputFile
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh \'OutputFile\' > $RESULTS_DIR/wf_upstream_of_OutputFile.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_OutputFile.gv > $RESULTS_DIR/wf_upstream_of_OutputFile.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_OutputFile.gv > $RESULTS_DIR/wf_upstream_of_OutputFile.svg

# draw worfklow graph upstream of MergedStream
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh \'MergedStream\' > $RESULTS_DIR/wf_upstream_of_MergedStream.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_MergedStream.gv > $RESULTS_DIR/wf_upstream_of_MergedStream.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_MergedStream.gv > $RESULTS_DIR/wf_upstream_of_MergedStream.svg

# draw worfklow graph upstream of LogFile
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh \'LogFile\' > $RESULTS_DIR/wf_upstream_of_LogFile.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_LogFile.gv > $RESULTS_DIR/wf_upstream_of_LogFile.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_LogFile.gv > $RESULTS_DIR/wf_upstream_of_LogFile.svg

# draw worfklow graph upstream of Marine
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh \'Marine\' > $RESULTS_DIR/wf_upstream_of_Marine.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_Marine.gv > $RESULTS_DIR/wf_upstream_of_Marine.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_Marine.gv > $RESULTS_DIR/wf_upstream_of_Marine.svg


##############
#   Q2_pro   #
##############

# list workflow inputs upstream of output data OutputFile
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh \'OutputFile\' OutputFile > $RESULTS_DIR/inputs_upstream_of_OutputFile.txt

# list workflow inputs upstream of intermediate data MergedStream
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh \'MergedStream\' MergedStream > $RESULTS_DIR/inputs_upstream_of_MergedStream.txt

##############
#   Q3_pro   #
##############

# draw workflow graph downstream of DataRecord
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh \'DataRecord\' > $RESULTS_DIR/wf_downstream_of_DataRecord.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_DataRecord.gv > $RESULTS_DIR/wf_downstream_of_DataRecord.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_DataRecord.gv > $RESULTS_DIR/wf_downstream_of_DataRecord.svg

# draw workflow graph downstream of Workspace
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh \'Workspace\' > $RESULTS_DIR/wf_downstream_of_Workspace.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_Workspace.gv > $RESULTS_DIR/wf_downstream_of_Workspace.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_Workspace.gv > $RESULTS_DIR/wf_downstream_of_Workspace.svg

##############
#   Q4_pro   #
##############

# list workflow outputs downstream of DataRecord
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh \'DataRecord\' DataRecord > $RESULTS_DIR/outputs_downstream_of_DataRecord.txt

# list workflow outputs downstream of Workspace
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh \'Workspace\' Workspace > $RESULTS_DIR/outputs_downstream_of_Workspace.txt

##############
#   Q6_pro   #
##############


# draw recon workflow graph with all observables

$QUERIES_DIR/render_recon_complete_wf_graph_q6.sh > $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv
dot -Tpdf $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.svg
