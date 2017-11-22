desc "実行環境を構築する"
task my_initializers: :environment do
  必須のミドルウェアがインストールされているか？
  if `which convert > /dev/null 2>&1; echo $?;`.to_i != 0
    raise 'imagemagicがインストールされていません。'
  end

  # pidファイル設置場所
  FileUtils.mkdir_p(Rails.application.config.common.nginx[:pid_dir])

  # デプロイシェルを設置
  `cp other_settings/deploy_lnes-manage.sh ..`
  
  # ステレージ設定を行なう
  # conoha_obs_conf = Rails.application.config.api.conoha_object_strage
  # os = OpenStack::Connection.create(
  #   :username => conoha_obs_conf[:user_id],
  #   :api_key => conoha_obs_conf[:password],
  #   :authtenant_id => conoha_obs_conf[:tenant_id],
  #   :auth_url => conoha_obs_conf[:auth_url],
  #   :service_type => "object-store",
  # )

  # os.create_container(conoha_obs_conf[:container_name], '.r:*')
  # os.create_container(conoha_obs_conf[:private_container_name], '.r:*')

  puts '実行環境の構築が完了しました。'
end

