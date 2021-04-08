import Foundation

struct InternetCredentialsPayload: CredentialPayloadable {

	// MARK: - Nested Types

	enum AuthenticationType {
		/// Windows NT LAN Manager authentication.
		case ntlm
		/// Microsoft Network default authentication.
		case msn
		/// Distributed Password authentication.
		case dpa
		/// Remote Password authentication.
		case rpa
		/// HTTP Basic authentication.
		case httpBasic
		/// HTTP Digest Access authentication.
		case httpDigest
		/// HTML form based authentication.
		case htmlForm
		/// The default authentication type.
		case `default`

		internal var cfString: CFString {
			switch self {
			case .ntlm:
				return kSecAttrAuthenticationTypeNTLM
			case .msn:
				return kSecAttrAuthenticationTypeMSN
			case .dpa:
				return kSecAttrAuthenticationTypeDPA
			case .rpa:
				return kSecAttrAuthenticationTypeRPA
			case .httpBasic:
				return kSecAttrAuthenticationTypeHTTPBasic
			case .httpDigest:
				return kSecAttrAuthenticationTypeHTTPDigest
			case .htmlForm:
				return kSecAttrAuthenticationTypeHTMLForm
			case .default:
				return kSecAttrAuthenticationTypeDefault
			}
		}
	}

	enum ServerProtocol {
		/// FTP protocol.
		case ftp
		/// A client side FTP account.
		case ftpAccount
		/// HTTP protocol.
		case http
		/// IRC protocol.
		case irc
		/// NNTP protocol.
		case nntp
		/// POP3 protocol.
		case pop3
		/// SMTP protocol.
		case smtp
		/// SOCKS protocol.
		case socks
		/// IMAP protocol.
		case imap
		/// LDAP protocol.
		case ldap
		/// AFP over AppleTalk.
		case appleTalk
		/// AFP over TCP.
		case afp
		/// Telnet protocol.
		case telnet
		/// SSH protocol.
		case ssh
		/// FTP over TLS/SSL.
		case ftps
		/// HTTP over TLS/SSL.
		case https
		/// HTTP proxy.
		case httpProxy
		/// HTTPS proxy.
		case httpsProxy
		/// FTP proxy.
		case ftpProxy
		/// SMB protocol.
		case smb
		/// RTSP protocol.
		case rtsp
		/// RTSP proxy.
		case rtspProxy
		/// DAAP protocol.
		case daap
		/// Remote Apple Events.
		case eppc
		/// IPP protocol.
		case ipp
		/// NNTP over TLS/SSL.
		case nntps
		/// LDAP over TLS/SSL.
		case ldaps
		/// Telnet over TLS/SSL.
		case telnetS
		/// IMAP over TLS/SSL.
		case imapS
		/// IRC over TLS/SSL.
		case ircS
		/// POP3 over TLS/SSL.
		case pop3S

		internal var cfString: CFString {
			switch self {
			case .ftp:
				return kSecAttrProtocolFTP
			case .ftpAccount:
				return kSecAttrProtocolFTPAccount
			case .http:
				return kSecAttrProtocolHTTP
			case .irc:
				return kSecAttrProtocolIRC
			case .nntp:
				return kSecAttrProtocolNNTP
			case .pop3:
				return kSecAttrProtocolPOP3
			case .smtp:
				return kSecAttrProtocolSMTP
			case .socks:
				return kSecAttrProtocolSOCKS
			case .imap:
				return kSecAttrProtocolIMAP
			case .ldap:
				return kSecAttrProtocolLDAP
			case .appleTalk:
				return kSecAttrProtocolAppleTalk
			case .afp:
				return kSecAttrProtocolAFP
			case .telnet:
				return kSecAttrProtocolTelnet
			case .ssh:
				return kSecAttrProtocolSSH
			case .ftps:
				return kSecAttrProtocolFTPS
			case .https:
				return kSecAttrProtocolHTTPS
			case .httpProxy:
				return kSecAttrProtocolHTTPProxy
			case .httpsProxy:
				return kSecAttrProtocolHTTPSProxy
			case .ftpProxy:
				return kSecAttrProtocolFTPProxy
			case .smb:
				return kSecAttrProtocolSMB
			case .rtsp:
				return kSecAttrProtocolRTSP
			case .rtspProxy:
				return kSecAttrProtocolRTSPProxy
			case .daap:
				return kSecAttrProtocolDAAP
			case .eppc:
				return kSecAttrProtocolEPPC
			case .ipp:
				return kSecAttrProtocolIPP
			case .nntps:
				return kSecAttrProtocolNNTPS
			case .ldaps:
				return kSecAttrProtocolLDAPS
			case .telnetS:
				return kSecAttrProtocolTelnetS
			case .imapS:
				return kSecAttrProtocolIMAPS
			case .ircS:
				return kSecAttrProtocolIRCS
			case .pop3S:
				return kSecAttrProtocolPOP3S
			}
		}
	}

	// MARK: - Properties

    //public let access (macOS only)
    let AccessGroup: String? //(iOS; also macOS if kSecAttrSynchronizable specified)
    let Accessible: String? // (iOS; also macOS if kSecAttrSynchronizable specified)
    let creationDate: Date?
    let modificationDate: Date?
    let description: String?
    let comment: String?
    let creator: CFNumber?
    let itemType: CFNumber?
    let label: String?
    let isInvisible: Bool?
    let isNegative: Bool?
    let securityDomain: String?
    let serverProtocol: ServerProtocol?
    let authenticationType: AuthenticationType?
    let port: CFNumber?
    let path: String?
    let synchronizable: Bool

    // MARK: - Init

    init(
        AccessGroup: String? = nil,
        Accessible: String? = nil,
        creationDate: Date? = nil,
        modificationDate: Date? = nil,
        description: String? = nil,
        comment: String? = nil,
        creator: CFNumber? = nil,
        itemType: CFNumber? = nil,
        label: String? = nil,
        isInvisible: Bool? = nil,
        isNegative: Bool? = nil,
        securityDomain: String? = nil,
        serverProtocol: InternetCredentialsPayload.ServerProtocol? = nil,
        authenticationType: InternetCredentialsPayload.AuthenticationType? = nil,
        port: CFNumber? = nil,
        path: String? = nil,
        synchronizable: Bool = false)
    {
        self.AccessGroup = AccessGroup
        self.Accessible = Accessible
        self.creationDate = creationDate
        self.modificationDate = modificationDate
        self.description = description
        self.comment = comment
        self.creator = creator
        self.itemType = itemType
        self.label = label
        self.isInvisible = isInvisible
        self.isNegative = isNegative
        self.securityDomain = securityDomain
        self.serverProtocol = serverProtocol
        self.authenticationType = authenticationType
        self.port = port
        self.path = path
        self.synchronizable = synchronizable
    }

	// MARK: - CredentialsPayload

	func makePayload() -> [String : Any] {
		[:] // TODO
	}

}
