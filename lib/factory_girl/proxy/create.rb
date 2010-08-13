class Factory
  class Proxy #:nodoc:
    class Create < Build #:nodoc:
      def result
        @instance = super
        run_callbacks(:before_create)
        run_callbacks(:after_build)
        @instance.save!
        run_callbacks(:after_create)
        @instance
      end
    end
  end
end
