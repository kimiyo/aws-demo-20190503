def ENVIRONMENT =""
def createBuildStage(props,comp) {
    return {
        stage("BUILD "+ comp.NAME) {
            if (comp.DESCRIPTION !=null) {
                echo comp.DESCRIPTION
            }
            echo "This is testing..."
        }
    }
}
pipeline {
    environment{
        props = "{}"
        andId = "Ant"
        jdkId = "jdk.0.8.0_181"
    }
    agent { node { label 'jhTestingNode' } }
    parameters {
        string (
            description: 'Release Number',
            defaultValue: '',
            name: 'RELEASENUMBER'
        )
        choice(
            description: 'Action',
            choices: '\napply\ndestroy',
            name: 'ACTION'
        )
        choice(
            description: 'Environment',
            choices: '\nDEV\nSIT\nUAT\nPROD',
            name: 'ENVIRONMENT'
        )
    }
    stages{
        stage("PREPARE: JSON FROM GIT" ){
            steps{
                script{
                    if (params.RELEASENUMBER==""){
                        echo "Please enter RELEASENUMBER"
                        return
                    }
                    if (params.ENVIRONMENT != ""){
                        ENVIRONMENT = params.ENVIRONMENT
                        echo "RELEASENUMBER: " + params.RELEASENUMBER
                        echo "ENVIRONMENT: " + params.ENVIRONMENT
                    }
                }
            }
        }
    }
}