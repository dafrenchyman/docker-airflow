#!/bin/bash

# Get Airflow web pod to set variables
export AIRFLOW_POD=`kubectl get pods | grep airflow-web -m 1| cut -f1 -d' '`

# Source env we will need
source ./airflow_vars.env

add_variables () {
    KEY=$1
    VALUE=$2
    kubectl exec ${AIRFLOW_POD} -- bash -c "/entrypoint.sh airflow variables --set ${KEY} ${VALUE}"
}

######################################
# Add variables to airflow
######################################

# Coldstart
add_variables invoice_processing_coldstart_counter 14
add_variables invoice_processing_coldstart_docker_tag c2aa307b1cf5b8fae69d40d5373d1d421beb5c75
add_variables invoice_processing_coldstart_repo us.gcr.io/prediction-service-models-qa
add_variables invoice_processing_coldstart_vhosts "[\"encompassmgmt\"]"

# Experiments
add_variables invoice_processing_experiments_always_train	True
add_variables invoice_processing_experiments_counter	17
add_variables invoice_processing_experiments_docker_tag	c2aa307b1cf5b8fae69d40d5373d1d421beb5c75
add_variables invoice_processing_experiments_obs_per_file	100
add_variables invoice_processing_experiments_repo us.gcr.io/prediction-service-models-qa
add_variables invoice_processing_experiments_vhosts "[\"actprop\", \"archerinvestment\", \"archways\", \"arthurthomas\", \"athomeapartments\", \"austincapitaladvisors\", \"az1strealty\", \"baboudjianprop\", \"bancalsf\", \"bandz\", \"barinvest2\", \"bayapartment\", \"blanchardandcalhoun\", \"bluediamond\", \"blumaxpartners\", \"bmoremanagement\", \"bridlewoodrecompany\", \"bristleconemgmt\", \"brokerscomm\", \"brownstonemgt\", \"bumanagement\", \"burlingtonrentals\", \"calson\", \"carsonproperties\", \"cavaliermgmt\", \"centerpoint2\", \"century21battlefield\", \"cfisandiego\", \"chamberlin\", \"circum\", \"cityrentals\", \"coastlineequity\", \"coastmanagement\", \"collegehousingnw\", \"compasscommercial\", \"conradpm\", \"courtyardproperties\", \"criteriaproperties\", \"ctrcos\", \"dcslmgmt\", \"delshah\", \"discala\", \"dolphinrealestate\", \"dover\", \"dphaurora\", \"duopropertymanagement\", \"duval\", \"ebrmanagement\", \"elevatesdproperties\", \"elkal\", \"encompassmgmt\", \"eqre\", \"equilibriumprops\", \"esa\", \"firstequityassociates\", \"firstw\", \"fivepnhholdingcompany\", \"gibson\", \"gorealtyco\", \"grindstone\", \"guerrette\", \"hammerandsaw\", \"hampshire\", \"harlamert\", \"headwayhomes\", \"heymingandjohnson\", \"hpmgmtinc\", \"ihacommercial\", \"iharesidential\", \"illicre\", \"investorspmgroup\", \"investwest\", \"jaasopm\", \"josephcompanies\", \"k3mgmt\", \"keenermanagement\", \"kelemencompany\", \"kfgpropertiesinc\", \"kiermgmt\", \"kinselameri\", \"kodiakpm\", \"land\", \"lapmg\", \"libertyproperties\", \"lmt\", \"lynxproperty\", \"madisonhill\", \"marathon\", \"marshallperry\", \"mccrealty\", \"mdatkinson\", \"meridiapm\", \"mgiglobal\", \"monroeavenue\", \"motwoprop\", \"mpminc\", \"mpsmanagement\", \"mtdpropertym\", \"mth\", \"murphyproperties\", \"nai1stvalley\", \"nautilus\", \"ncm\", \"nelsonminahanrealtors\", \"nexus\", \"nido\", \"nieblerproperties\", \"northwest\", \"northwestmanagement\", \"northwoodproperties\", \"otp\", \"parkplacemgmt\", \"pghnexus\", \"phillipsre\", \"pillarrei\", \"pilotnw\", \"pingreenw\", \"pm0vacancy\", \"podmajersky\", \"port\", \"prdcproperties\", \"premierres\", \"propertyhill\", \"quorumrealestate\", \"ralstonmgmt\", \"randpmllc\", \"redgroupny\", \"redside\", \"reichlekleingroup\", \"revisiongroup\", \"rhamco1\", \"robartsproperties\", \"rockproperties\", \"rocktownrealty\", \"roostdcllc\", \"rpmco007\", \"rpmne004\", \"sagepm\", \"scopeprops\", \"sdaptbrokers\", \"sdpropmgt\", \"sierraranch\", \"silverleafpmgmt\", \"skylinenewyork\", \"spectraassociates\", \"starmetro\", \"stephensargent\", \"sternproperty\", \"stratford\", \"sunrisemgmt\", \"thecoralcompany\", \"thelestergroup\", \"theschippergroup\", \"thewildcatgroup\", \"thosdwalsh\", \"threelestate\", \"tiaoproperties\", \"tjmg\", \"tmmrealestate\", \"trilliant\", \"trionprop\", \"turnstone\", \"uniquesolutions\", \"urbanhiveproperties\", \"urbankey\", \"utopiahoamanagement\", \"utopiamanagement\", \"valcorcre\", \"valleyincomeprop\", \"valstockmanagement\", \"vanguardpropertygroup\", \"vesacommercial\", \"virtuousmg\", \"volunteerproperties\", \"vpmi\", \"wallspropmgmt\", \"waltarnold\", \"wayfinder\", \"whalenproperties\", \"whitmoremanagementllc\", \"winstarproperties\", \"woodmont\", \"wooldridge\"]"

# Manual
add_variables invoice_processing_manual_always_train	True
add_variables invoice_processing_manual_counter	21
add_variables invoice_processing_manual_docker_tag	c2aa307b1cf5b8fae69d40d5373d1d421beb5c75
add_variables invoice_processing_manual_repo	us.gcr.io/prediction-service-models-qa
add_variables invoice_processing_manual_vhosts	"[\"allied\"]"

add_variables invoice_processing_reference_counter	13
add_variables invoice_processing_reference_docker_tag	c2aa307b1cf5b8fae69d40d5373d1d421beb5c75
add_variables invoice_processing_reference_repo	us.gcr.io/prediction-service-models-qa
add_variables invoice_processing_reference_vhosts "[\"valleyincomeprop\", \"arthurthomas\", \"austincapitaladvisors\", \"bayapartment\", \"blanchardandcalhoun\", \"brownstonemgt\", \"cavaliermgmt\", \"chamberlin\", \"circum\", \"criteriaproperties\", \"discala\", \"dolphinrealestate\", \"ebrmanagement\"]"

######################################
# Add connections to airflow
######################################

# Insert slack oauth
kubectl exec ${AIRFLOW_POD} -- bash -c "/entrypoint.sh airflow connections --add --conn_id slack_connection_airflow --conn_type http --conn_password ${SLACK_OAUTH}"

