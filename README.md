# concourse-deploy-gemfire

Deploy Gemfire with [omg](http://enaml.pezapp.io) in a Concourse pipeline.

## Prerequisites

1. [Git](https://git-scm.com)
1. [Concourse](http://concourse.ci)

## Steps to use this pipeline

1. Clone this repository.

    ```
    git clone https://github.com/c0-ops/concourse-deploy-gemfire.git
    ```

1. Copy the pipeline variables template.

    ```
    cp pipeline-vars-template.yml pipeline-vars.yml
    ```

1. Edit `pipeline-vars.yml`, adding appropriate values.

    ```
    $EDITOR pipeline-vars.yml
    ```

1. Create or update the pipeline.

    ```
    fly -t TARGET set-pipeline -p deploy-gemfire -c ci/pivotal-gemfire-service-pipeline.yml -l pipeline-vars.yml
    ```

    _or_

    ```
    fly -t TARGET set-pipeline -p deploy-gemfire -c ci/pivotal-gemfire-service-pipeline.yml -l pipeline-vars.yml
    ```

1. Delete or move `pipeline-vars.yml` to a secure location.
1. Unpause the pipeline

    ```
    fly -t TARGET unpause-pipeline -p deploy-gemfire
    ```

1. Trigger the deployment job and observe the output.

    ```
    fly -t TARGET trigger-job -j deploy-gemfire/get-product-version -w
    fly -t TARGET trigger-job -j deploy-gemfire/deploy -w
    ```
