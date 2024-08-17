require 'sys/cpu'
require 'sys/uname'
require 'json'

class SystemStatsController < ApplicationController
  def index
    @system_info = get_system_details
  end

  private

  def get_system_details
    {
      hostname: Sys::Uname.nodename,
      platform: Sys::Uname.sysname,
      architecture: Sys::Uname.machine,
      cpu_temp: get_cpu_temperature,
      cpu_usage: get_cpu_usage,
      memory_usage: get_memory_usage
    }
  end

  def get_cpu_temperature
    # You may need to adapt this depending on your system setup
    # For example, reading from a file that holds the CPU temperature
    File.read('/sys/class/thermal/thermal_zone0/temp').to_i / 1000.0
  end

  def get_cpu_usage
    Sys::CPU.load_avg.map { |load| (load * 100).round(2) }
  end

  def get_memory_usage
    total_memory = `free -g | grep Mem | awk '{print $2}'`.to_f
    used_memory = `free -g | grep Mem | awk '{print $3}'`.to_f

    {
      used: used_memory,
      total: total_memory
    }
  end
end