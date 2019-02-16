# frozen_string_literal: true

namespace :assets do
  desc 'Check if assets need to be precompiled'
  task :check do
    root_dir = File.join(File.dirname(__FILE__), '..', '..')
    assets_last_modified_at = Dir["#{root_dir}/app/assets/**/**"].map { |p| File.mtime(p) }.sort.last
    assets_last_compiled_at =  Dir["#{root_dir}/public/assets/**/**"].map { |p| File.mtime(p) }.sort.last

    if assets_last_modified_at > assets_last_compiled_at
      raise "Assets need to precompiled; last asset modified at #{assets_last_modified_at}"
    end
  end
end
