module Daemons
  module Rails
    class Controller
      attr_reader :path, :app_name

      def initialize(controller_path)
        @path = controller_path
        @app_name = "#{controller_path.basename.to_s[0..-'_ctrl'.length]}.rb"
      end

      def run(command)
        `#{path} #{command}`
      end

      def start
        run('start')
      end

      def stop
        run('stop')
      end

      def status
        run('status').to_s.split("\n").last =~ /: running \[pid \d+\]$/ ? :running : :not_exists
      end
    end
  end
end