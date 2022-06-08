legend_tags =  [];
for i = 1:length(a_list)
    i;
    a_mg = a_list(i,1);
    c_mg = c_list(i,1);
    K_mg = K_list(i,1);
    tag = "a:" + a_mg + "c:" + c_mg + "K_gain:" + K_mg;
    legend_tags = [legend_tags, tag];
end

radx_ar = [];
for i = 1:length(a_list)
    kkk = abs(radx_list(1).Data);
    radx_ar = [radx_ar, kkk];
end

radx_a = abs(radx_ar);
radx_summed = sum(radx_a, 1);

subplot(1,3,1)
plot(radx_list(1), 'r')
hold on
plot(radx_list(2), 'b')
hold on
plot(radx_list(3), 'o')
hold on
plot(radx_list(4), 'g')
hold on
plot(radx_list(5), 'y')
hold on
plot(radx_list(6), 'c')
hold on
plot(radx_list(7))

subplot(1,3,2)
plot(rady_list(1), 'r')
hold on
plot(rady_list(2), 'b')
hold on
plot(rady_list(3), 'o')
hold on
plot(rady_list(4), 'g')
hold on
plot(rady_list(5), 'y')
hold on
plot(rady_list(6), 'c')
hold on
plot(rady_list(7))

subplot(1,3,3)
plot(radz_list(1), 'r')
hold on
plot(radz_list(2), 'b')
hold on
plot(radz_list(3), 'o')
hold on
plot(radz_list(4), 'g')
hold on
plot(radz_list(5), 'y')
hold on
plot(radz_list(6), 'c')
hold on
plot(radz_list(7))

legend(legend_tags)