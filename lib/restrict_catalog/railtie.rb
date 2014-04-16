module RestrictCatalog
  class Railtie < Rails::Railtie
    initializer "my_railtie.configure_rails_initialization" do |app|
      FeatureBase.register(app, RestrictCatalog)
      FeatureBase.register_autoload_path(app, "restrict_catalog")
    end
    config.after_initialize do
      FeatureBase.inject_feature_record("Restrict Catalogs",
        "RestrictCatalog",
        "This will allow you to define which groups are allowed to access a catalog structure/root. Any child catalogs will also be accessible.  When this feature is enabled, all catalogs will be restricted by default."
      )
      FeatureBase.inject_permission_records(
        RestrictCatalog,
        RestrictCatalogFeatureDefinition.new.permissions
      )
    end
  end
end
