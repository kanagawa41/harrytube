CarrierWave.configure do |config|
  # if Rails.env.production?
    # ステレージ設定を行なう
    conoha_obs_conf = Rails.application.config.api.conoha_object_strage

    config.fog_credentials = {
      provider: 'OpenStack',
      openstack_tenant: conoha_obs_conf[:tenant_name],
      openstack_username: conoha_obs_conf[:user_id],
      openstack_api_key: conoha_obs_conf[:password],
      openstack_auth_url: conoha_obs_conf[:auth_url] + '/tokens',
    }

    container_name = "#{conoha_obs_conf[:container_name]}_#{Rails.env}"
    config.fog_directory = container_name
    config.storage :fog
    config.asset_host = "#{conoha_obs_conf[:end_point]}/#{container_name}"

  # else
  #   config.storage :file
  # end
end