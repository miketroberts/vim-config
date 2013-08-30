syn match       cppType         "\<Q[A-Za-z0-9_]*\>"
syn keyword     cppType         TString TNetworkProxy TNetworkReply TNetworkReplyImpl TNetworkRequest TNetworkRequestImpl TPostNetworkReply TPostNetworkReplyImpl
syn keyword     cppType         TNetworkAccessManager TNetworkAccessManagerImpl
syn keyword     cppPreCondit    Q_ASSERT SIGNAL SLOT

hi def link cppPreCondit		cPreCondit
