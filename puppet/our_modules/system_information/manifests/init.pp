# system_information
class system_information (
    $domain_name,
    $subdomain,
    $subdomain_separator,
    $tld,
    $use_ssl
  )
  {
    $domain_no_tld = "${subdomain}${domain_name}"
    $domain = "${domain_no_tld}.${tld}"

    $http_protocol = $use_ssl ? {
      true  => 'https',
      false => 'http'
    }

  $roles = {
    'api' => {
      'site_domain'   => $domain,
      'server_name'   => "api${subdomain_separator}${domain}",
      'upstream_port' => 4000,
      'proto'         => $http_protocol
    }
  }
}
