require 'globalize/backend/pluralizing'
require 'globalize/locale/fallbacks'
require 'globalize/translation'

module Globalize
  module Backend
    class Sql < Static
      def initialize(*args)
      end

      def translate(locale, key, options = {})
        raise InvalidLocale.new(locale) if locale.nil?
        return key.map { |k| translate(locale, k, options) } if key.is_a? Array

        reserved = :scope, :default
        count, scope, default = options.values_at(:count, *reserved)
        options.delete(:default)
        values = options.reject { |name, value| reserved.include?(name) }

        entry = nil
        fallback = nil
        I18n.fallbacks[locale].each do |fallback|
          entry = lookup(fallback, key, scope) and break
        end
        entry = default(locale, default, options) if entry.nil?
        return nil if entry.nil?

        entry = pluralize(locale, entry, count)
        entry = interpolate(locale, entry, values)

        attrs = {:requested_locale => locale, :locale => fallback, :key => key, :options => options}
        translation(entry, attrs) || raise(I18n::MissingTranslationData.new(locale, key, options))
      end

      def available_locales
        init_translations unless initialized?
        translations.keys.inject([]) { |locales, account| locales += translations[account].keys }
      end

      protected

        def init_translations
          load_table
          @initialized = true
        end

        def load_table
          phrases = Phrase.connection.select_rows("select coalesce(p.account_id || '','global') || '.' || t.locale || '.' || p.key as key, t.string as string from phrases p join phrase_translations t on t.phrase_id = p.id")
          phrases.each do |phrase|
            keys = phrase[0].split(/\./).map(&:to_sym)
            hsh = keys[0..-2].inject(translations) do |memo, k|
              memo[k] ||= {}
            end
            hsh[keys[-1]] = phrase[1]
          end
        end

        def lookup_account(account, locale, key, scope)
          keys = [account ? account.id.to_s.to_sym : :global] + I18n.send(:normalize_translation_keys, locale, key, scope)
          keys.inject(translations) do |result, k|
            if (x = result[k.to_sym]).nil?
              return nil
            else
              x
            end
          end
        end

        def lookup(locale, key, scope = [])
          return unless key
          init_translations unless initialized?
          lookup_account(Thread.current[:account], locale, key, scope) || lookup_account(nil, locale, key, scope)
        end

    end
  end
end

