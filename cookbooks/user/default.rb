require "itamae/secrets"

node[:secrets] = Itamae::Secrets(File.join(__dir__, "../../secret"))

node[:users].each do |u|

  pass = (node[:secrets][:"#{u[:password_secret_name]}"]) ? node[:secrets][:"#{u[:password_secret_name]}"] : nil
  user u[:name] do
    gid u[:group] ? u[:group] : "wheel"
    password pass if pass
  end

  directory "/home/#{u[:name]}" do
    owner u[:name]
    mode "755"
  end

  if u[:ssh_key_secret_names].count > 0 then

    directory "/home/#{u[:name]}/.ssh" do
      owner u[:name]
      mode "700"
    end

    ssh_keys = []
    u[:ssh_key_secret_names].each do |key_secret|
       ssh_keys.push(node[:secrets][:"#{key_secret}"] << "\n")
    end

    ssh_key = ssh_keys.join
    file "/home/#{u[:name]}/.ssh/authorized_keys" do
      content ssh_key
      owner u[:name]
      mode "600"
    end
  end


end
