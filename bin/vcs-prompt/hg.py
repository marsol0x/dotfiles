import sh
import os

class HG:

    def __init__(self):
        sh.hg("root") # Throw an error and die if this ever fails

        self._status = [i for i in sh.hg("status").split('\n') if len(i) > 0]
        self._build_status_dict()

        self._branch = sh.hg("branch").split('\n')[0]

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
        summary = sh.hg("summary")
        if "current" in summary.split(':')[-1]:
            return False
        return True

    def is_clean(self):
        if self.num_staged() or self.num_modified() or self.num_untracked():
            return False
        else:
            return True

    def changeset(self):
        return sh.hg("id").strip('\n').split()[0]
