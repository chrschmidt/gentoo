# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A rapid whole genome aligner"
HOMEPAGE="http://mummer.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/mummer/MUMmer${PV}.tar.gz"
S="${WORKDIR}/MUMmer${PV}"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	app-shells/tcsh
	dev-lang/perl"

PATCHES=(
	"${FILESDIR}"/${PN}-3.23-fix-build-system.patch
	"${FILESDIR}"/${PN}-3.23-fix-c++-qa.patch
	"${FILESDIR}"/${PN}-3.23-fix-shebangs.patch
)

src_configure() {
	use amd64 && append-cppflags -DSIXTYFOURBITS
	tc-export AR CC CXX
}

src_install() {
	dobin src/kurtz/mm3src/mummer
	dobin src/tigr/{combineMUMs,delta-filter,gaps,mgaps,postnuc,postpro,prenuc,prepro,repeat-match,show-aligns,show-coords,show-tiling,show-snps,show-diff}
	dobin scripts/{exact-tandems,mapview,mummerplot,dnadiff,nucmer,promer,run-mummer1,run-mummer3,nucmer2xfig}
	newbin src/tigr/annotate mummer-annotate

	insinto /usr/share/mummer/lib
	doins scripts/Foundation.pm

	einstalldocs
	use doc && dodoc -r docs/.
}
