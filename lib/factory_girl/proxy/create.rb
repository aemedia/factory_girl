class Factory
  class Proxy #:nodoc:
    class Create < Build #:nodoc:
      def result
        @instance = super
        @callbacks[:before_create].call(@instance) if @callbacks[:before_create]
        @instance.save!
        @callbacks[:after_create].call(@instance) if @callbacks[:after_create]
        @instance
      end
    end
  end
end
