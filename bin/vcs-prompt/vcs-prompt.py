#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import os
from git import Git
from hg import HG
from subprocess import Popen, PIPE

glyphs = {
        "repo"      : u'',
        "untracked" : u'…',
        "modified"  : u'+',
        "staged"    : u'•',
        "clean"     : u'✓',
        "ahead"     : u'↑',
        "behind"    : u'↓',
    }
colors = {
        "NORMAL" : u'%F{reset}',
        "BLUE"   : u'%F{blue}',
        "CYAN"   : u'%F{cyan}',
        "GREEN"  : u'%F{green}',
        "PURPLE" : u'%F{magenta}',
        "RED"    : u'%F{red}',
        "WHITE"  : u'%F{white}',
        "YELLOW" : u'%F{yellow}',
    }

def is_cwd_repo():
    out, err = Popen(["git", "rev-parse", "--git-dir"], stdout=PIPE, stderr=PIPE).communicate()
    if not err:
        return out.splitlines()[0]

    out, err = Popen(["hg", "root"], stdout=PIPE, stderr=PIPE).communicate()
    if not err:
        return out.splitlines()[0]

    return False

def vcs_prompt(path):
    repo = None
    if os.path.basename(path) == ".git":
        repo = Git()
    else:
        repo = HG()

    branch = repo.branch()
    untracked = repo.num_untracked()
    modified = repo.num_modified()
    staged = repo.num_staged()
    update = repo.need_update()
    clean = repo.is_clean()
    changeset = repo.changeset()
    ahead, behind = repo.remote_commits()

    # Construct prompt
    output = unicode(errors="replace")
    if repo.__class__ == Git:
        output += colors['GREEN']
    else:
        output += colors['BLUE']
    output += glyphs["repo"] + colors['NORMAL']
    output += colors['PURPLE'] + branch + colors['NORMAL']
    output += " " + colors['YELLOW'] + changeset + colors['NORMAL']
    change_string = unicode(errors="replace")

    if clean and not update and not (ahead or behind):
        change_string += colors['GREEN'] + glyphs['clean'] + colors['NORMAL']
    else:
        if staged:
            change_string += colors['RED'] + glyphs['staged'] + str(staged) + colors['NORMAL']
        if staged and (modified or untracked):
            change_string += u"|"
        if modified:
            change_string += colors['GREEN'] + glyphs['modified'] + str(modified)
            if untracked:
                change_string += glyphs['untracked']
            change_string += colors['NORMAL']
        elif untracked:
            change_string += colors['YELLOW'] + glyphs['modified'] + str(untracked) + glyphs['untracked'] + colors['NORMAL']

    if change_string:
        output += u" " + change_string

    if ahead:
        output += colors['BLUE'] + glyphs['ahead'] + u"%d" % (ahead) + colors['NORMAL']

    if behind:
        output += colors['CYAN'] + glyphs['behind'] + u"%d" % (behind) + colors['NORMAL']

    if update:
        output += colors['RED'] + u" !" + colors['NORMAL']

    print output.encode("UTF-8")
        

if __name__ == '__main__':
    cwd = is_cwd_repo()
    if cwd:
        vcs_prompt(cwd)
