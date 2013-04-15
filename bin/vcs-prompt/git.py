import sh
import os

class Git:

    def __init__(self):
        sh.git("rev-parse") # Throw error and die if this ever fails

        self._status = [i for i in sh.git("status", "-s", "--porcelain").split('\n') if len(i) > 0]
        self._build_status_dict()

        branch = sh.git("branch", "--no-color")
        self._branch = ""
        if branch:
            self._branch = [i for i in branch.split('\n') if len(i) > 0 and i[0] == '*'][0].split()[-1]

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
        return sh.git("rev-parse", "--short", "HEAD").strip('\n')
