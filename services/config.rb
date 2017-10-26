coreo_agent_selector_rule 'check-docker' do
  action :define
  timeout 30
  control 'check-docker' do
    describe command('docker') do
        it { should exist }
    end
  end
end

coreo_agent_audit_profile 'cis-docker-benchmark' do
  action :define
  selectors ['check-docker']
  profile 'https://github.com/dev-sec/cis-docker-benchmark/archive/master.zip'
  timeout 120
end

coreo_agent_selector_rule 'check-kubectl' do
  action :define
  timeout 30
  control 'check-kubectl' do
    describe command('kubectl') do
        it { should exist }
    end
  end
end

coreo_agent_audit_profile 'cis-kubernetes-benchmark' do
  action :define
  selectors ['check-kubectl']
  profile 'https://github.com/dev-sec/cis-kubernetes-benchmark/archive/master.zip'
  timeout 120
end

coreo_agent_rule_runner 'cis-applications-agent-rules' do
  action :run
  profiles ${AUDIT_AGENT_APPLICATIONS_PROFILES_ALERT_LIST}
  filter(${FILTERED_OBJECTS}) if ${FILTERED_OBJECTS}
end
