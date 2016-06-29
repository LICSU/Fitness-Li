﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LicsuWeb.Validado.Datos
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="licsu_web")]
	public partial class LicsuDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Definiciones de métodos de extensibilidad
    partial void OnCreated();
    partial void InsertUsuario(Usuario instance);
    partial void UpdateUsuario(Usuario instance);
    partial void DeleteUsuario(Usuario instance);
    #endregion
		
		public LicsuDataContext() : 
				base(global::System.Configuration.ConfigurationManager.ConnectionStrings["licsu_webConnectionString"].ConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public LicsuDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public LicsuDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public LicsuDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public LicsuDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<Usuario> Usuarios
		{
			get
			{
				return this.GetTable<Usuario>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.Usuario")]
	public partial class Usuario : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private long _UsuarioID;
		
		private string _UsuarioCedula;
		
		private string _UsuarioClave;
		
		private string _UsuarioNombre;
		
		private string _UsuarioApellido;
		
		private string _UsuarioCorreo;
		
		private System.Nullable<System.DateTime> _UsuarioFechaNacimiento;
		
		private System.Nullable<char> _UsuarioEstadoCivil;
		
		private System.Nullable<char> _UsuarioSexo;
		
		private string _UsuarioTelefono;
		
		private string _UsuarioCelular1;
		
		private string _UsuarioCelular2;
		
		private string _UsuarioObservacion;
		
		private bool _UsuarioActivo;
		
		private System.DateTime _UsuarioFechaRegistro;
		
		private string _UsuarioUsuarioRegistro;
		
		private string _UsuarioFoto;
		
    #region Definiciones de métodos de extensibilidad
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnUsuarioIDChanging(long value);
    partial void OnUsuarioIDChanged();
    partial void OnUsuarioCedulaChanging(string value);
    partial void OnUsuarioCedulaChanged();
    partial void OnUsuarioClaveChanging(string value);
    partial void OnUsuarioClaveChanged();
    partial void OnUsuarioNombreChanging(string value);
    partial void OnUsuarioNombreChanged();
    partial void OnUsuarioApellidoChanging(string value);
    partial void OnUsuarioApellidoChanged();
    partial void OnUsuarioCorreoChanging(string value);
    partial void OnUsuarioCorreoChanged();
    partial void OnUsuarioFechaNacimientoChanging(System.Nullable<System.DateTime> value);
    partial void OnUsuarioFechaNacimientoChanged();
    partial void OnUsuarioEstadoCivilChanging(System.Nullable<char> value);
    partial void OnUsuarioEstadoCivilChanged();
    partial void OnUsuarioSexoChanging(System.Nullable<char> value);
    partial void OnUsuarioSexoChanged();
    partial void OnUsuarioTelefonoChanging(string value);
    partial void OnUsuarioTelefonoChanged();
    partial void OnUsuarioCelular1Changing(string value);
    partial void OnUsuarioCelular1Changed();
    partial void OnUsuarioCelular2Changing(string value);
    partial void OnUsuarioCelular2Changed();
    partial void OnUsuarioObservacionChanging(string value);
    partial void OnUsuarioObservacionChanged();
    partial void OnUsuarioActivoChanging(bool value);
    partial void OnUsuarioActivoChanged();
    partial void OnUsuarioFechaRegistroChanging(System.DateTime value);
    partial void OnUsuarioFechaRegistroChanged();
    partial void OnUsuarioUsuarioRegistroChanging(string value);
    partial void OnUsuarioUsuarioRegistroChanged();
    partial void OnUsuarioFotoChanging(string value);
    partial void OnUsuarioFotoChanged();
    #endregion
		
		public Usuario()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioID", DbType="BigInt NOT NULL", IsPrimaryKey=true)]
		public long UsuarioID
		{
			get
			{
				return this._UsuarioID;
			}
			set
			{
				if ((this._UsuarioID != value))
				{
					this.OnUsuarioIDChanging(value);
					this.SendPropertyChanging();
					this._UsuarioID = value;
					this.SendPropertyChanged("UsuarioID");
					this.OnUsuarioIDChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioCedula", DbType="VarChar(20) NOT NULL", CanBeNull=false)]
		public string UsuarioCedula
		{
			get
			{
				return this._UsuarioCedula;
			}
			set
			{
				if ((this._UsuarioCedula != value))
				{
					this.OnUsuarioCedulaChanging(value);
					this.SendPropertyChanging();
					this._UsuarioCedula = value;
					this.SendPropertyChanged("UsuarioCedula");
					this.OnUsuarioCedulaChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioClave", DbType="VarChar(20) NOT NULL", CanBeNull=false)]
		public string UsuarioClave
		{
			get
			{
				return this._UsuarioClave;
			}
			set
			{
				if ((this._UsuarioClave != value))
				{
					this.OnUsuarioClaveChanging(value);
					this.SendPropertyChanging();
					this._UsuarioClave = value;
					this.SendPropertyChanged("UsuarioClave");
					this.OnUsuarioClaveChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioNombre", DbType="VarChar(60) NOT NULL", CanBeNull=false)]
		public string UsuarioNombre
		{
			get
			{
				return this._UsuarioNombre;
			}
			set
			{
				if ((this._UsuarioNombre != value))
				{
					this.OnUsuarioNombreChanging(value);
					this.SendPropertyChanging();
					this._UsuarioNombre = value;
					this.SendPropertyChanged("UsuarioNombre");
					this.OnUsuarioNombreChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioApellido", DbType="VarChar(60) NOT NULL", CanBeNull=false)]
		public string UsuarioApellido
		{
			get
			{
				return this._UsuarioApellido;
			}
			set
			{
				if ((this._UsuarioApellido != value))
				{
					this.OnUsuarioApellidoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioApellido = value;
					this.SendPropertyChanged("UsuarioApellido");
					this.OnUsuarioApellidoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioCorreo", DbType="VarChar(50)")]
		public string UsuarioCorreo
		{
			get
			{
				return this._UsuarioCorreo;
			}
			set
			{
				if ((this._UsuarioCorreo != value))
				{
					this.OnUsuarioCorreoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioCorreo = value;
					this.SendPropertyChanged("UsuarioCorreo");
					this.OnUsuarioCorreoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioFechaNacimiento", DbType="DateTime")]
		public System.Nullable<System.DateTime> UsuarioFechaNacimiento
		{
			get
			{
				return this._UsuarioFechaNacimiento;
			}
			set
			{
				if ((this._UsuarioFechaNacimiento != value))
				{
					this.OnUsuarioFechaNacimientoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioFechaNacimiento = value;
					this.SendPropertyChanged("UsuarioFechaNacimiento");
					this.OnUsuarioFechaNacimientoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioEstadoCivil", DbType="Char(1)")]
		public System.Nullable<char> UsuarioEstadoCivil
		{
			get
			{
				return this._UsuarioEstadoCivil;
			}
			set
			{
				if ((this._UsuarioEstadoCivil != value))
				{
					this.OnUsuarioEstadoCivilChanging(value);
					this.SendPropertyChanging();
					this._UsuarioEstadoCivil = value;
					this.SendPropertyChanged("UsuarioEstadoCivil");
					this.OnUsuarioEstadoCivilChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioSexo", DbType="Char(1)")]
		public System.Nullable<char> UsuarioSexo
		{
			get
			{
				return this._UsuarioSexo;
			}
			set
			{
				if ((this._UsuarioSexo != value))
				{
					this.OnUsuarioSexoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioSexo = value;
					this.SendPropertyChanged("UsuarioSexo");
					this.OnUsuarioSexoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioTelefono", DbType="VarChar(20)")]
		public string UsuarioTelefono
		{
			get
			{
				return this._UsuarioTelefono;
			}
			set
			{
				if ((this._UsuarioTelefono != value))
				{
					this.OnUsuarioTelefonoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioTelefono = value;
					this.SendPropertyChanged("UsuarioTelefono");
					this.OnUsuarioTelefonoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioCelular1", DbType="VarChar(20)")]
		public string UsuarioCelular1
		{
			get
			{
				return this._UsuarioCelular1;
			}
			set
			{
				if ((this._UsuarioCelular1 != value))
				{
					this.OnUsuarioCelular1Changing(value);
					this.SendPropertyChanging();
					this._UsuarioCelular1 = value;
					this.SendPropertyChanged("UsuarioCelular1");
					this.OnUsuarioCelular1Changed();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioCelular2", DbType="VarChar(20)")]
		public string UsuarioCelular2
		{
			get
			{
				return this._UsuarioCelular2;
			}
			set
			{
				if ((this._UsuarioCelular2 != value))
				{
					this.OnUsuarioCelular2Changing(value);
					this.SendPropertyChanging();
					this._UsuarioCelular2 = value;
					this.SendPropertyChanged("UsuarioCelular2");
					this.OnUsuarioCelular2Changed();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioObservacion", DbType="VarChar(250)")]
		public string UsuarioObservacion
		{
			get
			{
				return this._UsuarioObservacion;
			}
			set
			{
				if ((this._UsuarioObservacion != value))
				{
					this.OnUsuarioObservacionChanging(value);
					this.SendPropertyChanging();
					this._UsuarioObservacion = value;
					this.SendPropertyChanged("UsuarioObservacion");
					this.OnUsuarioObservacionChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioActivo", DbType="Bit NOT NULL")]
		public bool UsuarioActivo
		{
			get
			{
				return this._UsuarioActivo;
			}
			set
			{
				if ((this._UsuarioActivo != value))
				{
					this.OnUsuarioActivoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioActivo = value;
					this.SendPropertyChanged("UsuarioActivo");
					this.OnUsuarioActivoChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioFechaRegistro", DbType="DateTime NOT NULL")]
		public System.DateTime UsuarioFechaRegistro
		{
			get
			{
				return this._UsuarioFechaRegistro;
			}
			set
			{
				if ((this._UsuarioFechaRegistro != value))
				{
					this.OnUsuarioFechaRegistroChanging(value);
					this.SendPropertyChanging();
					this._UsuarioFechaRegistro = value;
					this.SendPropertyChanged("UsuarioFechaRegistro");
					this.OnUsuarioFechaRegistroChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioUsuarioRegistro", DbType="VarChar(50) NOT NULL", CanBeNull=false)]
		public string UsuarioUsuarioRegistro
		{
			get
			{
				return this._UsuarioUsuarioRegistro;
			}
			set
			{
				if ((this._UsuarioUsuarioRegistro != value))
				{
					this.OnUsuarioUsuarioRegistroChanging(value);
					this.SendPropertyChanging();
					this._UsuarioUsuarioRegistro = value;
					this.SendPropertyChanged("UsuarioUsuarioRegistro");
					this.OnUsuarioUsuarioRegistroChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UsuarioFoto", DbType="VarChar(100)")]
		public string UsuarioFoto
		{
			get
			{
				return this._UsuarioFoto;
			}
			set
			{
				if ((this._UsuarioFoto != value))
				{
					this.OnUsuarioFotoChanging(value);
					this.SendPropertyChanging();
					this._UsuarioFoto = value;
					this.SendPropertyChanged("UsuarioFoto");
					this.OnUsuarioFotoChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
}
#pragma warning restore 1591
