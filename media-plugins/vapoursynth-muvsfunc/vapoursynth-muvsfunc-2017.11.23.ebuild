# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="Muonium's VapourSynth functions"
HOMEPAGE="https://github.com/WolframRhodium/muvsfunc"

EGIT_REPO_URI="https://github.com/WolframRhodium/muvsfunc.git"
EGIT_COMMIT="a7191b9b64fed7374d4358209fbca1dbe0ad81a2"
KEYWORDS="~amd64 ~x86"

IUSE="misc numpy deprecated"
LICENSE=""
SLOT="0"

RDEPEND+="
	numpy? ( dev-python/numpy[${PYTHON_USEDEP}] )
	media-libs/vapoursynth[${PYTHON_USEDEP},vapoursynth_plugins_miscfilters,vapoursynth_plugins_removegrain]
	media-plugins/vapoursynth-havsfunc[${PYTHON_USEDEP}]
	deprecated? ( media-plugins/vapoursynth-knlmeanscl )
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-mvsfunc[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-tcanny
	misc? ( media-plugins/vapoursynth-vcfreq )
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule muvsfunc.py
	if use misc; then
		python_domodule Collections/muvsfunc_misc.py
    fi
    if use numpy; then
		python_domodule Collections/muvsfunc_numpy.py
    fi
    if use deprecated; then
		python_domodule Collections/{LUM,SuperRes}.py
    fi
}
