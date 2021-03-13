import Leaf
import Vapor
import FluentPostgreSQL
import Authentication

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
  /// Register providers first
  try services.register(LeafProvider())
  try services.register(FluentPostgreSQLProvider())

  /// Register routes to the router
  let router = EngineRouter.default()
  try routes(router)
  services.register(router, as: Router.self)
  
  /// Use Leaf for rendering views
  config.prefer(LeafRenderer.self, for: ViewRenderer.self)

  /// Register middleware
  var middlewares = MiddlewareConfig()
  middlewares.use(FileMiddleware.self)
  middlewares.use(ErrorMiddleware.self)
  middlewares.use(SessionsMiddleware.self)
  services.register(middlewares)
  
  // Authentication
  try services.register(AuthenticationProvider())
  config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
  
  // Database
  let envURL = Environment.get("DATABASE_URL")
  let altURL = "postgres://website@localhost:5432/website"
  let transport: PostgreSQLConnection.TransportConfig = env == .development ? .cleartext : .unverifiedTLS
  
  if let postgresqlConfig = PostgreSQLDatabaseConfig(url: envURL ?? altURL, transport: transport) {
    services.register(postgresqlConfig)
    let postgres = PostgreSQLDatabase(config: postgresqlConfig)
    
    var databases = DatabasesConfig()
    databases.add(database: postgres, as: .psql)
    services.register(databases)
  }

  // Configure migrations
  var migrations = MigrationConfig()
  
  // MARK: - Wish (general)
  
  migrations.add(
    migration: WishState.self,
    database: DatabaseIdentifier<PostgreSQLDatabase>.psql
  )
  
  // MARK: - socialdown
  
  migrations.add(
    model: socialdown_User.self,
    database: DatabaseIdentifier<socialdown_User.Database>.psql
  )
  migrations.add(
    migration: socialdown_Wish.State.self,
    database: DatabaseIdentifier<socialdown_Wish.State.Database>.psql
  )
  migrations.add(
    model: socialdown_Wish.self,
    database: DatabaseIdentifier<socialdown_Wish.Database>.psql
  )
  migrations.add(
    model: socialdown_UserWish.self,
    database: DatabaseIdentifier<socialdown_UserWish.Database>.psql
  )
  
  // MARK: - Better Workout
  
   migrations.add(
     model: bw_User.self,
     database: DatabaseIdentifier<bw_User.Database>.psql
   )
   migrations.add(
     model: bw_Wish.self,
     database: DatabaseIdentifier<bw_Wish.Database>.psql
   )
   migrations.add(
     model: bw_UserWish.self,
     database: DatabaseIdentifier<bw_UserWish.Database>.psql
   )
  
  // MARK: - Admin Panel
  
  migrations.add(
    model: AdminUser.self,
    database: DatabaseIdentifier<AdminUser.Database>.psql
  )
  
  // MARK: - Migration (Changes)
  
  // State Migration
  
  migrations.add(
    migration: SocialDownChangeStateTypeMigration.self,
    database: DatabaseIdentifier<SocialDownChangeStateTypeMigration.Database>.psql
  )
  
  services.register(migrations)
}
