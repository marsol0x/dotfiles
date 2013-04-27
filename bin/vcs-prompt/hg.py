from subprocess import Popen, PIPE
import os

class HG:

    def __init__(self):
        out, err = Popen(["hg", "status"], stdout=PIPE, stderr=PIPE).communicate()
        if not err:
            self._status = [i for i in out.splitlines()]
            self._build_status_dict()

        out, err = Popen(["hg", "branch"], stdout=PIPE, stderr=PIPE).communicate()
        if not err:
            self._branch = out.splitlines()[0]

    def _build_status_dict(self):
        self._status_dict = {}
        for i in self._status:
            l = i.split()
            st = l[0]
            if not self._status_dict.has_key(st):
                self._status_dict[st] = 1
            else:
                self._status_dict[st] += 1

    def branch(self):
        return self._branch

    def num_untracked(self):
        if self._status_dict.has_key("?"):
            return self._status_dict["?"]
        else:
            return 0

    def num_modified(self):
        if self._status_dict.has_key("M"):
            return self._status_dict["M"]
        else:
            return 0

    def num_staged(self):
        if self._status_dict.has_key("A"):
            return self._status_dict["A"]
        else:
            return 0

    def need_update(self):
        out, err = Popen(["hg", "summary"], stdout=PIPE, stderr=PIPE).communicate()
        if not err and "current" in out.splitlines()[-1]:
            return False
        return True

    def is_clean(self):
        if self.num_staged() or self.num_modified() or self.num_untracked():
            return False
        else:
            return True

    def changeset(self):
        out, err = Popen(["hg", "id"], stdout=PIPE, stderr=PIPE).communicate()
        if not err:
            return out.split()[0]
