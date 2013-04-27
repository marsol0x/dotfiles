from subprocess import Popen, PIPE
import os

class Git:

    def __init__(self):
        out, err = Popen(["git", "status", "-s", "--porcelain"], stdout=PIPE, stderr=PIPE).communicate()
        if not err:
            self._status = [i for i in out.splitlines()]
            self._build_status_dict()

        out, err = Popen(["git", "branch", "--no-color"], stdout=PIPE, stderr=PIPE).communicate()
        if not err and len(out):
            self._branch = filter(lambda x: '*' in x, out.splitlines())[0].split()[-1]
        else:
            self._branch = out

    def _build_status_dict(self):
        self._status_dict = {}
        for i in self._status:
            st = i[0:2]
            if not self._status_dict.has_key(st):
                self._status_dict[st] = 1
            else:
                self._status_dict[st] += 1

    def branch(self):
        return self._branch

    def num_untracked(self):
        if self._status_dict.has_key("??"):
            return self._status_dict["??"]
        else:
            return 0

    def num_modified(self):
        num = 0
        keys = [i for i in self._status_dict.keys() if 'M' in i]
        if not keys:
            return 0
        for i in keys:
            num += self._status_dict[i]
        return num

    def num_staged(self):
        num = 0
        keys = [i for i in self._status_dict.keys() if 'A' in i]
        if not keys:
            return 0
        for i in keys:
            num += self._status_dict[i]
        return num

    def is_clean(self):
        if self.num_staged() or self.num_modified() or self.num_untracked():
            return False
        else:
            return True

    def need_update(self):
        return False

    def changeset(self):
        out, err = Popen(["git", "rev-parse", "--short", "HEAD"], stdout=PIPE, stderr=PIPE).communicate()
        if not err:
            return out.splitlines()[0]
        else:
            return ""
