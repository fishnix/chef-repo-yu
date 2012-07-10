action :create_if_missing do
  execute "create blackhole route if missing" do
    not_if "/sbin/ip route list #{new_resource.name} | grep blackhole"
    command "/sbin/ip route add blackhole #{new_resource.name}"
  end
end

action :remove do
  execute "remove blackhole route" do
    only_if "/sbin/ip route list #{new_resource.name} | grep blackhole"
    command "/sbin/ip route del blackhole #{new_resource.name}"
  end
end