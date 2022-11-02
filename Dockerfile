# A basic container image for the following Makefile target deps:
#
#* `make`
#  * `make lint`
#    * [yamllint](https://github.com/adrienverge/yamllint)
#    * [bashate](https://github.com/openstack/bashate)
#  * `make generate`
#    * [kustomize](https://kustomize.io/)
#  * `make validate`
#    * [kustomize](https://kustomize.io/)
#    * [kubeconform](https://github.com/yannh/kubeconform)
#  * `make readme`
#    * [yq](https://github.com/mikefarah/yq)
#* `make schema` (optional)
#  * [openapi2jsonschema](https://github.com/instrumenta/openapi2jsonschema)

FROM quay.io/fedora/fedora:latest

RUN dnf install -y make git golang python3-pip

# yamllint bashate openapi2jsonschema
RUN pip install yamllint bashate openapi2jsonschema

# kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && mv /kustomize /bin/kustomize

# kubeconform
RUN go install github.com/yannh/kubeconform/cmd/kubeconform@latest && mv /root/go/bin/kubeconform /bin/kubeconform

# Download latest yq binary
RUN curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq