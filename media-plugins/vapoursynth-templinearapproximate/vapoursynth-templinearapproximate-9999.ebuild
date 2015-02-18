# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit python-utils-r1 python-single-r1 toolchain-funcs multilib

DESCRIPTION="Takes several frames and for each pixel calculates linear approximation of its values through time"
HOMEPAGE="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth.git"
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libtemplinearapproximate.so"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) src/processplane.c src/main.c || die "Build failed"
}

src_install() {
	insinto "$(python_get_sitedir)"
	doins MCDenoise.py
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc TempLinearApproximate-readme.txt LICENSE
}
