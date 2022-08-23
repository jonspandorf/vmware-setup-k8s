# This script generates a terraform module and output for each cluster

import json
import os 

def generate_ip_list(first_address):
    pass


def create_module():
    # List of container's envs from jenkins 
    jenkins_tfvars = [
        "vcenter_ip",
        "esxi_hostname",
        "vcenter_username",
        "vcenter_password",
        "vcenter_datacenter",
        "datastore",
        "resource_pool",
        "num_of_masters",
        "num_of_workers",
        "is_dhcp",
        "first_ip"
        "vcpu",
        "ram",
        "disk_size",
        "provision_type",
        "current_cluster_num",
    ]
    cluster_num = os.getenv('current_cluster_num')
    tfvars = {"module": {f"cluster-{cluster_num}": {"source": "/module"}} }

   # Generates the dictrionary
    for var in jenkins_tfvars:
        if var == "first_ip":
            continue
        elif var == "resource_pool":
            tfvars["module"][f"cluster-{cluster_num}"].update({var: os.getenv(var)+"_"+os.getenv("Cluster_Num")})
        elif var == "is_dhcp":
            if not os.getenv(var):
                 tfvars["module"][f"cluster-{cluster_num}"].update({"static_ips": generate_ip_list(os.getenv('first_ip'))})
        else:
             tfvars["module"][f"cluster-{cluster_num}"].update({var: os.getenv(var)})

    output_vars = f"${{module.cluster-{cluster_num}.variables}}"
    output_vms = f"${{module.cluster-{cluster_num}.real_vms}}"

   # Adds the output
    tfvars.update({"output": {"variables": {"value": output_vars }}})
    tfvars["output"].update({"real_vms": {"value": output_vms }})

    os.mkdir(f'/data/cluster-{cluster_num}')
    
    with open(f'/data/cluster-{cluster_num}/launch.tf.json', 'w') as f:
        json.dump(tfvars,f,indent=4)
    return 

if __name__ == "__main__":
    create_module()