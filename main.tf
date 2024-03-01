terraform { 
  required_version = ">= 0.14.0"  
  required_providers {    
    openstack = {     
      source  = "terraform-provider-openstack/openstack"                        
      version = "~> 1.41.0"
    }  
  }
}

 
resource "openstack_compute_instance_v2" "basic" {
  name            = "neil_terraform_test_minio"
  image_name      = "focal-server-cloudimg-amd64"
  flavor_name     = "4cpu_8mem_10disk"
  key_pair        = "willia83"
  security_groups = []
  user_data       = "${data.cloudinit_config.minio.rendered}"

   
 
  network {
    name = "nc_vnf_mgmt_cas_dmz_3_pn_1366"
  }
}

 
data "cloudinit_config" "minio" {
  gzip          = false
  base64_encode = false
  part {
    filename = "script2.sh"
    content_type = "text/x-shellscript"
    content = file("${path.module}/hello-script.sh")
  }
  part {
    filename = "script1.py"
    content_type = "text/x-shellscript"
    content = file("${path.module}/hello-script.py")
  }
  part {
    filename = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content = file("${path.module}/cloud-config.yaml")
  }
}