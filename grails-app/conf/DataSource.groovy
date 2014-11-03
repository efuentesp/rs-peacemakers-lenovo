
dataSource {
	   pooled = true
	   driverClassName = "com.mysql.jdbc.Driver"
	   dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
}
hibernate {
	   cache.use_second_level_cache = true
	   cache.use_query_cache = true
	   cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}


// environment specific settings
environments {
	   development {
			  dataSource {
					 //dbCreate = "create" // one of 'create', 'create-drop','update'
					   dbCreate = "update"
					 url = "jdbc:mysql://127.0.0.1:3306/peacemakers-dev?useUnicode=yes&characterEncoding=UTF-8"
					 username = "admin"
					 password = "toor"
			  }
			  hibernate {
					 show_sql = false
			  }
			  properties
			  {
				  maxActive = 50
				  maxIdle = 25
				  minIdle =1
				  initialSize = 1
				  minEvictableIdleTimeMillis = 60000
				  timeBetweenEvictionRunsMillis = 60000
				  numTestsPerEvictionRun = 3
				  maxWait = 10000
  
				  testOnBorrow = true
				  testWhileIdle = true
				  testOnReturn = false
  
				  validationQuery = "SELECT 1"
			  }
	   }
	   test {
			  dataSource {
					 dbCreate = "create-drop" // one of 'create', 'create-drop','update'
					 url = "jdbc:mysql://127.0.0.1:3306/peacemakers-test?useUnicode=yes&characterEncoding=UTF-8"
					 username = "grails"
					 password = "toor"
			  }
	   }
	   production {
			  dataSource {
					 dbCreate = "update"
					 url = "jdbc:mysql://127.0.0.1:3306/peacemakers-prod?useUnicode=yes&characterEncoding=UTF-8"
					 username = "root"
					 password = "toor"
					 
					 properties
					 {
						 maxActive = 50
						 maxIdle = 25
						 minIdle =1
						 initialSize = 1
						 minEvictableIdleTimeMillis = 60000
						 timeBetweenEvictionRunsMillis = 60000
						 numTestsPerEvictionRun = 3
						 maxWait = 10000
		 
						 testOnBorrow = true
						 testWhileIdle = true
						 testOnReturn = false
		 
						 validationQuery = "SELECT 1"
					 }
			  }
	   }
}