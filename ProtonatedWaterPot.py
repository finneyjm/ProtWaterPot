import os, sys


class Potential:

    has_been_loaded = False

    def __init__(self, natm):
        if self.has_been_loaded:
            raise Exception("Can't load this potential twice")
        self._natm = natm
        self.load_potential()

    def init_potential(self):
        cur_dir = os.getcwd()
        try:
            where_u_at = os.path.join(
                os.path.dirname(__file__),
                "f2py_prot_water_pot"
            )
            os.chdir(where_u_at)
            sys.path.insert(0, where_u_at)

            try:
                import ProtWaterPot
            except ImportError:
                self.compile_potential(True)
            ProtWaterPot.init_param(self._natm)
            self._pot = ProtWaterPot.proto_potcalc
        finally:
            os.chdir(cur_dir)

    def get_potential(self, coords):
        """Assumes coords in (nwalkers, natm, 3)

        :param coords:
        :type coords:
        :return:
        :rtype:
        """
        return self._pot(coords.T, len(coords), self._natm)  # do the real thing

    def load_potential(self):
        self.init_potential()
        cls = type(self)
        cls.has_been_loaded = True

    @staticmethod
    def compile_potential(called_from_error):
        # if called_from_error:
        os.chdir("..")
        # else:
        #     os.chdir(os.path.dirname(__file__))
        import subprocess
        subprocess.call(["bash", "build.sh"])
