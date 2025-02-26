component name='application' accessors=true output=false persistent=false {
	
	this.datasources.test = {
	  class: 'org.h2.Driver'
			, bundleName: 'org.h2'
			, bundleVersion: '1.3.172'
	, connectionString: 'jdbc:h2:#getDirectoryFromPath(getCurrentTemplatePath())#/datasource/db;MODE=MySQL'
	};
	
	this.name = 'test966';
	
	this.applicationTimeout	= createTimeSpan(2, 0, 0, 0);
	this.sessionManagement	= true;
	this.sessionTimeout		= createTimeSpan(0, 4, 0, 0);
	this.setClientCookies	= true;
	this.setDomainCookies	= false;
	
	this.ormenabled = true;
	this.ormsettings.autogenmap			= true;
	this.ormsettings.cfclocation		= ['/orm'];
	this.ormsettings.logsql				= false;
	//this.ormsettings.dialect			= 'MySQL5';
	this.ormsettings.useDBForMapping	= false;
	this.ormsettings.eventHandling		= true;
	this.ormsettings.datasource			= 'test';
	this.ormsettings.dbcreate			= 'update';
	this.ormsettings.flushatrequestend	= true;
	this.ormsettings.autoManageSession	= false;
	
	public function onRequestStart() {
		setting requesttimeout=10;
	}
	
	function onRequestEnd() {
		var javaIoFile=createObject("java","java.io.File");
		loop array=DirectoryList(
			path=getDirectoryFromPath(getCurrentTemplatePath()), 
			recurse=true, filter="*.db") item="local.path"  {
			fileDeleteOnExit(javaIoFile,path);
		}
	}

	private function fileDeleteOnExit(required javaIoFile, required string path) {
		var file=javaIoFile.init(arguments.path);
		if(!file.isFile())file=javaIoFile.init(expandPath(arguments.path));
		if(file.isFile()) file.deleteOnExit();
	}
}