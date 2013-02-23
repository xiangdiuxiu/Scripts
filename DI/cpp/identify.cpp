//v0.01
//Author: ZhangYet
//

mat makeNetwork(mat data, double alpha)
{
  mat net = cor(data);
  uvec indices_0 = find(net<alpha);
  uvec indices_1 = find(net>=alpha);
  net.elem(indices_0) = zeros<vec>(indice_0.n_elem);
  net.elem(indices_1) = ones<vec>(indice_1.n_elem);
  return net;
}
