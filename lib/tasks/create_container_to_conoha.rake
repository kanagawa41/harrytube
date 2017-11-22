desc "Conoha Object Strageにコンテナを構築する"
task create_container_to_conoha: :environment do
  require 'fog'

  # ステレージ設定を行なう
  conoha_obs_conf = Rails.application.config.api.conoha_object_strage

  service = Fog::Storage.new(
    provider: 'OpenStack',
    openstack_tenant: conoha_obs_conf[:tenant_name],
    openstack_username: conoha_obs_conf[:user_id],
    openstack_api_key: conoha_obs_conf[:password],
    openstack_auth_url: conoha_obs_conf[:auth_url] + '/tokens',
  )

  container_name = "#{conoha_obs_conf[:container_name]}_#{Rails.env}"
  service.put_container(container_name,
      public: true, headers: { 'X-Web-Mode' => 'true' })

  puts 'コンテナの構築が完了しました。'
end