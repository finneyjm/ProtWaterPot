
subroutine pot_calc(n, atm, x, pot)
implicit real*8(a-h, o-z)
integer,intent(in)::natm
integer,intent(in)::n
double precision, dimension(3, natm, n), intent(in) :: x
double precision, dimension(n), intent(out) :: pot
do k = 1,n
    call geth3opot(pot(k), x(:, :, k))
enddo
return
end subroutine

subroutine init_params()
implicit real*8(a-h,o-z)
call preh3opot()
return
end subroutine
