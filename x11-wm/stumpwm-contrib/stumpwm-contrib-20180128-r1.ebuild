# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit common-lisp-3

DESCRIPTION="Extension Modules for StumpWM"
HOMEPAGE="https://github.com/stumpwm/stumpwm-contrib/"

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/stumpwm/stumpwm-contrib/"
else
	SRC_URI="mirror://gentoo/f8/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 GPL-3 BSD-2"
SLOT="0"

RDEPEND=">=x11-wm/stumpwm-1.0.0"

CONTRIBCATEGORIES="media minor-mode modeline util"

src_install() {
	common-lisp-install-sources -t all ${CONTRIBCATEGORIES}
	dobin util/stumpish/stumpish
	dobin util/pinentry/stumpwm-pinentry
	dodoc README.org
}
