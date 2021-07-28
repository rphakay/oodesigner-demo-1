namespace: Integrations.hcm202107_demo
flow:
  name: deploy_aos
  inputs:
    - target_host: demo.hcmx.local
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 94
        'y': 83
      install_java:
        x: 225
        'y': 183.203125
      install_tomcat:
        x: 366
        'y': 257.203125
      install_aos_application:
        x: 553
        'y': 283.203125
        navigate:
          fecbde11-a096-9eca-4e21-36831bf75b74:
            targetId: e5d8a43a-da9f-d7cd-ccc8-7c8d3a8b1fdb
            port: SUCCESS
    results:
      SUCCESS:
        e5d8a43a-da9f-d7cd-ccc8-7c8d3a8b1fdb:
          x: 742
          'y': 262
