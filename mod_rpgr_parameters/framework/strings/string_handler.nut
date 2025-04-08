::PRM.Strings <-
{
	function createTables()
	{
		this.Generic <- {};
		this.Settings <- {};
	}

	function compileFragments( _fragmentsArray, _colour )
	{
		local compiledString = "";
		local colourWrap = @(_string) _colour == null ? _string : ::PRM.Standard.colourWrap(_string, _colour);

		if (_fragmentsArray.len() % 2 != 0)
		{
			_fragmentsArray.push("");
		}

		for( local i = 0; i < _fragmentsArray.len(); i++ )
		{
			local fragment = i % 2 == 0 ? _fragmentsArray[i] : colourWrap(_fragmentsArray[i]);
			compiledString = ::PRM.Standard.appendToStringList(fragment, compiledString, "");
		}

		return compiledString;
	}

	function getFragmentsAsCompiledString( _fragmentBase, _tableKey, _subTableKey = null, _colour = ::PRM.Standard.Colour.Red )
	{
		local fragmentsArray = this.getFragmentsAsSortedArray(_fragmentBase, _tableKey, _subTableKey);
		return this.compileFragments(fragmentsArray, _colour);
	}

	function getFragmentsAsSortedArray( _fragmentBase, _tableKey, _subTableKey )
	{
		local fragmentKeys = [];
		local database = _subTableKey == null ? this[_tableKey] : this[_tableKey][_subTableKey];

		foreach( key, string in database )
		{
			if (key.find(_fragmentBase) != null)
			{
				fragmentKeys.push(key);
			}
		}

		fragmentKeys.sort();
		return fragmentKeys.map(@(_fragmentKey) database[_fragmentKey]);
	}

	function getField( _tableName, _fieldName )
	{
		local field = this.getTopLevelField(_tableName, _fieldName);

		if (field == null)
		{
			::PRM.Standard.log(format("Could not find %s in the specified string database %s.", _fieldName, _tableName), true);
		}

		return field;
	}

	function getTopLevelField( _tableName, _fieldName )
	{
		if (!(_fieldName in this[_tableName]))
		{
			return null;
		}

		return this[_tableName][_fieldName];
	}

	function initialise()
	{
		this.createTables();
		this.loadFiles();
	}

	function loadFiles()
	{
		this.loadFolder("settings");
	}

	function loadFolder( _path )
	{
		::PRM.Manager.includeFiles(format("mod_rpgr_parameters/framework/strings/%s", _path));
	}
};