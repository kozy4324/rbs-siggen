# steep:ignore:start
require "rbs/test/tester"

module RBS
  module Test
    class Tester
      def install!(klass, sample_size:, unchecked_classes:)
        RBS.logger.info { "Installing runtime type checker in #{klass}..." }

        type_name = factory.type_name(klass.name).absolute!

        builder.build_instance(type_name).tap do |definition|
          instance_key = new_key(type_name, "InstanceChecker")
          tester, set = instance_testers[klass] ||= [
            MethodCallTester.new(klass, builder, definition, kind: :instance, sample_size: sample_size, unchecked_classes: unchecked_classes),
            Set[]
          ]
          Observer.register(instance_key, tester)

          definition.methods.each do |name, method|
            if reason = skip_method?(type_name, method)
              unless reason == :implemented_in
                RBS.logger.info { "Skipping ##{name} because of `#{reason}`..." }
              end
            else
              if !set.include?(name) && (
                  name == :initialize ||
                  klass.instance_methods(false).include?(name) ||
                  klass.private_instance_methods(false).include?(name)) ||
                  method.annotations.any? {|a| a.string == "rbs:test:target" }
                m = klass.new.method(name) rescue nil
                if m
                  RBS.logger.info { "Setting up method hook in ##{name}..." }
                  Hook.hook_instance_method klass, name, key: instance_key
                  set << name
                end
              end
            end
          end
        end

        builder.build_singleton(type_name).tap do |definition|
          singleton_key = new_key(type_name, "SingletonChecker")
          tester, set = singleton_testers[klass] ||= [
            MethodCallTester.new(klass.singleton_class, builder, definition, kind: :singleton, sample_size: sample_size, unchecked_classes: unchecked_classes),
            Set[]
          ]
          Observer.register(singleton_key, tester)

          definition.methods.each do |name, method|
            if reason = skip_method?(type_name, method)
              unless reason == :implemented_in
                RBS.logger.info { "Skipping .#{name} because of `#{reason}`..." }
              end
            else
              if klass.methods(false).include?(name) && !set.include?(name)
                RBS.logger.info { "Setting up method hook in .#{name}..." }
                Hook.hook_singleton_method klass, name, key: singleton_key
                set << name
              end
            end
          end
        end

        targets << klass
      end
    end
  end
end
# steep:ignore:end
