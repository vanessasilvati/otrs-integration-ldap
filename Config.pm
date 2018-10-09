# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
#  Note:
#
#  -->> Most OTRS configuration should be done via the OTRS web interface
#       and the SysConfig. Only for some configuration, such as database
#       credentials and customer data source changes, you should edit this
#       file. For changes do customer data sources you can copy the definitions
#       from Kernel/Config/Defaults.pm and paste them in this file.
#       Config.pm will not be overwritten when updating OTRS.
# --

package Kernel::Config;

use strict;
use warnings;
use utf8;

sub Load {
    my $Self = shift;

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
    $Self->{'DatabaseHost'} = '127.0.0.1';

    # The database name
    $Self->{'Database'} = "otrs";

    # The database user
    $Self->{'DatabaseUser'} = "root";

    # The password of database user. You also can use bin/otrs.Console.pl Maint::Database::PasswordCrypt
    # for crypted passwords
    $Self->{'DatabasePw'} = 'Suporte@@2018';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $Self->{'DatabaseDSN'} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost}";

    # The database DSN for PostgreSQL ==> more: "perldoc DBD::Pg"
    # if you want to use a local socket connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};";
    # if you want to use a TCP/IP connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};host=$Self->{DatabaseHost};";

    # The database DSN for Microsoft SQL Server - only supported if OTRS is
    # installed on Windows as well
#    $Self->{DatabaseDSN} = "DBI:ODBC:driver={SQL Server};Database=$Self->{Database};Server=$Self->{DatabaseHost},1433";

    # The database DSN for Oracle ==> more: "perldoc DBD::oracle"
#    $Self->{DatabaseDSN} = "DBI:Oracle://$Self->{DatabaseHost}:1521/$Self->{Database}";
#
#    $ENV{ORACLE_HOME}     = '/path/to/your/oracle';
#    $ENV{NLS_DATE_FORMAT} = 'YYYY-MM-DD HH24:MI:SS';
#    $ENV{NLS_LANG}        = 'AMERICAN_AMERICA.AL32UTF8';

    # ---------------------------------------------------- #
    # fs root directory
    # ---------------------------------------------------- #
    $Self->{Home} = '/opt/otrs';

#Adicionando o Campo CPF ao Cadastro do Cliente

 $Self->{CustomerUser} = {
 Name => 'Database Backend',
 Module => 'Kernel::System::CustomerUser::DB',
 Params => {
 Table => 'customer_user',
 CaseSensitive => 0,
 },
 CustomerKey => 'login',
 CustomerID => 'customer_id',
 CustomerValid => 'valid_id',
 CustomerUserListFields => [ 'first_name', 'last_name', 'email' ],
 CustomerUserSearchFields => [ 'login', 'first_name', 'last_name', 'customer_id' ],
 CustomerUserSearchPrefix => '*',
 CustomerUserSearchSuffix => '*',
 CustomerUserSearchListLimit => 250,
 CustomerUserPostMasterSearchFields => ['email'],
 CustomerUserNameFields => [ 'title', 'first_name', 'last_name' ],
 CustomerUserEmailUniqCheck => 1,
 CustomerCompanySupport => 1,
 CacheTTL => 60 * 60 * 24,
 Map => [
# var, frontend, storage, shown (1=always,2=lite), required, storage-type, http-link, readonly, http-link-target, link class(es)
 [ 'UserTitle', 'Title', 'title', 1, 0, 'var', '', 0 ],
 [ 'UserFirstname', 'Firstname', 'first_name', 1, 1, 'var', '', 0 ],
 [ 'UserLastname', 'Lastname', 'last_name', 1, 1, 'var', '', 0 ],
 [ 'UserLogin', 'Username', 'login', 1, 1, 'var', '', 0 ],
 [ 'UserPassword', 'Password', 'pw', 0, 0, 'var', '', 0 ],
 [ 'UserEmail', 'Email', 'email', 1, 1, 'var', '', 0 ],
 [ 'UserCustomerID', 'CustomerID', 'customer_id', 0, 1, 'var', '', 0 ],
 [ 'UserPhone', 'Phone', 'phone', 1, 0, 'var', '', 0 ],
 [ 'UserCPF', 'Cadastro de Pessoa Fisica (CPF)', 'cpf', 1, 1, 'var', '', 0 ],
 [ 'UserFax', 'Fax', 'fax', 1, 0, 'var', '', 0 ],
 [ 'UserMobile', 'Mobile', 'mobile', 1, 0, 'var', '', 0 ],
 [ 'UserStreet', 'Street', 'street', 1, 0, 'var', '', 0 ],
 [ 'UserZip', 'Zip', 'zip', 1, 0, 'var', '', 0 ],
 [ 'UserCity', 'City', 'city', 1, 0, 'var', '', 0 ],
 [ 'UserCountry', 'Country', 'country', 1, 0, 'var', '', 0 ],
 [ 'UserComment', 'Comment', 'comments', 1, 0, 'var', '', 0 ],
 [ 'ValidID', 'Valid', 'valid_id', 0, 1, 'int', '', 0 ],
 ],
 };

##############################################

    # ---------------------------------------------------- #
    # insert your own config settings "here"               #
    # config settings taken from Kernel/Config/Defaults.pm #
    # ---------------------------------------------------- #
    # $Self->{SessionUseCookie} = 0;
    # $Self->{CheckMXRecord} = 0;
      $Self->{SecureMode} = 1; #Esse modo ativado "bloqueia" o installer.pl de ser executado novamente. Para desativar basta colocar o "0" no lugar do 1.

###################################################################
# Exibe os colaboradores do AD como clientes internos #
# Lembre-se que os usuários no AD devem ter o campo mail #
# preenchido corretamente #
###################################################################
$Self->{CustomerUser1} = {
 Name => 'Open LDAP',
 Module => 'Kernel::System::CustomerUser::LDAP',
 Params => {
 Host => 'localhost.dc.br', # ALTERAR
 BaseDN => 'dc=xx,dc=xx', # ALTERAR
 SSCOPE => 'sub',
 UserDN => '',
 UserPw => '',
 SourceCharset => 'utf-8',
 DestCharset => 'utf-8',
 Params => {
 port => 389,
 timeout => 120,
 async => 0,
 version => 3,
 },
 },
 CustomerKey => 'uid',
 CustomerID => 'uid',
 CustomerUserListFields => ['cn','mail'],
 CustomerUserSearchFields => ['uid', 'cn', 'mail','givenname', 'sn'],
 CustomerUserSearchPrefix => '*',
 CustomerUserSearchSuffix => '*',
 CustomerUserSearchListLimit => '*',
 CustomerUserPostMasterSearchFields => ['mail'],
 CustomerUserNameFields => ['givenname', 'sn'],
 CustomerUserEmailUniqCheck => 0,
 CustomerUserExcludePrimaryCustomerID => 0,
 AdminSetPreferences => 0,
 ReadOnly => 1,
 CacheTTL => 180,
 Map => [
# note: Login, Email and CustomerID are mandatory!
# var, frontend, storage, shown (1=always,2=lite), required, storage-type, http-link, readonly
 [ 'UserTitle', 'Title', 'title', 1, 0, 'var', '', 0 ],
 [ 'UserFirstname', 'Firstname', 'givenname', 1, 1, 'var', '', 0 ],
 [ 'UserLastname', 'Lastname', 'sn', 1, 1, 'var', '', 0 ],
 [ 'UserLogin', 'Username', 'uid', 1, 1, 'var', '', 0 ],
 [ 'UserEmail', 'Email', 'mail', 0, 0, 'var', '', 0 ],
 [ 'UserCustomerID', 'CustomerID', 'uid', 0, 1, 'var', '', 0 ],
 [ 'UserPhone', 'Phone', 'telephonenumber', 1, 0, 'var', '', 0 ],
 [ 'UserAddress', 'Address', 'postaladdress', 1, 0, 'var', '', 0 ],
 [ 'UserComment', 'Comment', 'dn', 1, 0, 'var', '', 0 ],
 [ 'DN', 'DN', 'dn', 1, 0, 'var', '', 0 ],
 ],
};

#LDAP Cliente Auth
    $Self->{'Customer::AuthModule1'} = 'Kernel::System::CustomerAuth::LDAP';
    $Self->{'Customer::AuthModule::LDAP::Host1'} = 'ldapserver.xxx.br'; #ALTERAR
    $Self->{'Customer::AuthModule::LDAP::BaseDN1'} = 'dc=xxx,dc=xxx'; #ALTERAR
    $Self->{'Customer::AuthModule::LDAP::UID1'} = 'uid';

#LDAP Agent Auth LDAP 1
 $Self->{AuthModule1} = 'Kernel::System::Auth::DB';
 $Self->{AuthModule2} = 'Kernel::System::Auth::LDAP';
 $Self->{'AuthModule::LDAP::Host2'} = 'ldapserver.xxx.br'; #ALTERAR
 $Self->{'AuthModule::LDAP::BaseDN2'} = 'dc=xxx,dc=xx'; #ALTERAR
 $Self->{'AuthModule::LDAP::UID2'} = 'uid';
# $Self->{'AuthModule::LDAP::GroupDN2'} = 'cn=XXX,ou=groups,dc=XXX,dc=XXXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
# $Self->{'AuthModule::LDAP::AccessAttr2'} = 'member'; 
# $Self->{'AuthModule::LDAP::SearchUserDN2'} = 'cn=XX,dc=XX,dc=XXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
# $Self->{'AuthModule::LDAP::SearchUserPw2'} = 'XXXXXX'; #ALTERAR SE NECESSÁRIO PARA TESTES

#LDAP Agent Auth LDAP 2
 $Self->{AuthModule1} = 'Kernel::System::Auth::DB';
 $Self->{AuthModule3} = 'Kernel::System::Auth::LDAP';
 $Self->{'AuthModule::LDAP::Host3'} = 'ldapserver.xxx.br'; #ALTERAR
 $Self->{'AuthModule::LDAP::BaseDN3'} = 'dc=xxx,dc=xx'; #ALTERAR
 $Self->{'AuthModule::LDAP::UID3'} = 'uid';
# $Self->{'AuthModule::LDAP::GroupDN3'} = 'cn=XXX,ou=groups,dc=XXX,dc=XXXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
# $Self->{'AuthModule::LDAP::AccessAttr3'} = 'member';
# $Self->{'AuthModule::LDAP::SearchUserDN3'} = 'cn=XX,dc=XX,dc=XXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
# $Self->{'AuthModule::LDAP::SearchUserPw3'} = 'XXXXXX'; #ALTERAR SE NECESSÁRIO PARA TESTES

# Agent data sync against LDAP 1
$Self->{'AuthSyncModule2'} = 'Kernel::System::Auth::Sync::LDAP';
$Self->{'AuthSyncModule::LDAP::Host2'} = 'ldapserver.xxx.br'; #ALTERAR
$Self->{'AuthSyncModule::LDAP::BaseDN2'} = 'dc=xxx,dc=xx'; #ALTERAR
$Self->{'AuthSyncModule::LDAP::UID2'} = 'uid';
#$Self->{'AuthSyncModule::LDAP::SearchUserDN2'} = 'cn=XX,dc=XX,dc=XXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
#$Self->{'AuthSyncModule::LDAP::SearchUserPw2'} = 'XXXXXX'; #ALTERAR SE NECESSÁRIO PARA TESTES
$Self->{'AuthSyncModule::LDAP::UserSyncMap2'} = {
    # DB -> LDAP
    UserFirstname => 'givenName',
    UserLastname  => 'sn',
    UserEmail     => 'mail',
};


# Agent data sync against LDAP 2
$Self->{'AuthSyncModule3'} = 'Kernel::System::Auth::Sync::LDAP';
$Self->{'AuthSyncModule::LDAP::Host3'} = 'ldapserver.xxx.br'; #ALTERAR
$Self->{'AuthSyncModule::LDAP::BaseDN3'} = 'dc=xxx,dc=xx'; #ALTERAR
$Self->{'AuthSyncModule::LDAP::UID3'} = 'uid';
#$Self->{'AuthSyncModule::LDAP::SearchUserDN3'} = 'cn=XX,dc=XX,dc=XXX,dc=XX'; #ALTERAR SE NECESSÁRIO PARA TESTES
#$Self->{'AuthSyncModule::LDAP::SearchUserPw3'} = 'XXXXXX'; #ALTERAR SE NECESSÁRIO PARA TESTES
$Self->{'AuthSyncModule::LDAP::UserSyncMap3'} = {
    # DB -> LDAP
    UserFirstname => 'givenName',
    UserLastname  => 'sn',
    UserEmail     => 'mail',
};

# AuthSyncModule::LDAP::UserSyncInitialGroups
# (sync following group with rw permission after initial create of first agent
# login)
    $Self->{'AuthSyncModule::LDAP::UserSyncInitialGroups2'} = [
        'users',
    ];

# AuthSyncModule::LDAP::UserSyncInitialGroups
# (sync following group with rw permission after initial create of first agent
# login)
    $Self->{'AuthSyncModule::LDAP::UserSyncInitialGroups3'} = [
        'users',
    ];


    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    # data inserted by installer                           #
    # ---------------------------------------------------- #
    # $DIBI$

    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    #                                                      #
    # end of your own config options!!!                    #
    #                                                      #
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #

    return 1;
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #

use Kernel::Config::Defaults; # import Translatable()
use parent qw(Kernel::Config::Defaults);

# -----------------------------------------------------#

1;
