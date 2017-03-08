% Quiver, with subsampling
%
% Usage: [Ox,Oy] = vis_flow (Vx, Vy, gx, offset, mag, col)
% or     H = vis_flow (Vx, Vy, gx, offset, mag, col)
%

function [Ox,Oy] = vis_flow (VVx, VVy, gx, offset, mag, col);

if (nargin<3)
	gx = 25;
end
if (nargin<4)
	offset = 0;
end
if (nargin<5)
	mag = 1;
end
if (nargin<6)
	col = 'b';
end

[sy sx] = size(VVx);
if (gx==0)
	jmp = 1;
else
	jmp = floor(sx/gx);
	jmp = jmp + (jmp==0);
end

indx = (offset+1):jmp:sx;
c = 1;
CX = [];
CY = [];
for j=(1+offset):jmp:sy
	Vx(c,:) = VVx(j,indx);
	Vy(c,:) = VVy(j,indx);
	CX(c,:) = indx;
	%CY(c,:) = ones(size(indx)).*(sy-j+1);
	CY(c,:) = ones(size(indx)).*j;
	c = c+1;
end

if (isnan(Vx(1,1)))
	Vx(1,1) = 1;
	Vy(1,1) = 0;
	CX(1,1) = 1;
	CY(1,1) = 1;
end

M = ~isnan(Vx) & ~isnan(Vy);
H = quiver (CX(M), CY(M), Vx(M), Vy(M), mag);
s = size(VVx);
axis ([0 s(2) 0 s(1)]);
set (H, 'Color', col);

switch nargout
	case 0
		clear Ox;
		clear Oy;
	case 1
		Ox = H;
	otherwise
		Ox = Vx;
		Oy = Vy;
end

