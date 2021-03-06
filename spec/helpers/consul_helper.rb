# frozen_string_literal: true

require 'docker'
require_relative './hash_helper'

module ConsulHelper
  def default_options
    { 'name' => "consul_#{Time.now.to_i}",
      'Image' => 'consul:latest',
      'HostConfig' => {
        'PortBindings' => {
          '8500/tcp' => [{ 'HostPort' => '8500' }]
        }
      },
      'Hostname' => 'consul' }
  end

  def start_consul_container(opts = {})
    options = default_options.deep_merge opts
    Docker::Image.create('fromImage' => 'consul:latest', 'Ports' => []) unless Docker::Image.exist? 'consul:latest'
    @consul_container = Docker::Container.create(
      options
    )
    @consul_container.start
    @consul_id = @consul_container.id[0..10]
    sleep(10)
  end

  def stop_consul_container
    @consul_container.stop
    @consul_container.delete
  end

  def container_name
    @consul_container.name
  end
end
