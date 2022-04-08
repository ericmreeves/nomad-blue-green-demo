. ./aws-creds
pushd terraform/control
terraform output
$(terraform output | grep export)
popd
