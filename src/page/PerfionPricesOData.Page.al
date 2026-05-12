page 50228 "PerfionPricesOData"
{
    Caption = 'Perfion Prices OData';
    AdditionalSearchTerms = 'SCANPAN, OData, Perfion, dw, price, pricelist';
    UsageCategory = Administration;

    PageType = List;
    SourceTable = "Price List Line";
    SourceTableTemporary = true;
    ODataKeyFields = SystemId;

    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    Permissions =
        tabledata "Price List Line" = R,
        tabledata Campaign = R;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId) { Caption = 'systemId'; }
                field(itemNo; Rec."Asset No.") { Caption = 'itemNo'; }

                field(priceAmazonDeEurStk; PriceAmazonDeEurStk) { Caption = 'priceAmazonDeEurStk'; }
                field(recommendedPriceAmazonDeEurStk; RecommendedPriceAmazonDeEurStk) { Caption = 'recommendedPriceAmazonDeEurStk'; }
                field(campaignPriceAmazonDeEurStk; CampaignPriceAmazonDeEurStk) { Caption = 'campaignPriceAmazonDeEurStk'; }
                field(priceAmazonEsEurStk; PriceAmazonEsEurStk) { Caption = 'priceAmazonEsEurStk'; }
                field(recommendedPriceAmazonEsEurStk; RecommendedPriceAmazonEsEurStk) { Caption = 'recommendedPriceAmazonEsEurStk'; }
                field(campaignPriceAmazonEsEurStk; CampaignPriceAmazonEsEurStk) { Caption = 'campaignPriceAmazonEsEurStk'; }
                field(priceAuUsdBase; PriceAuUsdBase) { Caption = 'priceAuUsdBase'; }
                field(recommendedPriceAuUsdBase; RecommendedPriceAuUsdBase) { Caption = 'recommendedPriceAuUsdBase'; }
                field(campaignPriceAuUsdBase; CampaignPriceAuUsdBase) { Caption = 'campaignPriceAuUsdBase'; }
                field(priceAuUsdCdu; PriceAuUsdCdu) { Caption = 'priceAuUsdCdu'; }
                field(recommendedPriceAuUsdCdu; RecommendedPriceAuUsdCdu) { Caption = 'recommendedPriceAuUsdCdu'; }
                field(campaignPriceAuUsdCdu; CampaignPriceAuUsdCdu) { Caption = 'campaignPriceAuUsdCdu'; }
                field(priceAuUsdStk; PriceAuUsdStk) { Caption = 'priceAuUsdStk'; }
                field(recommendedPriceAuUsdStk; RecommendedPriceAuUsdStk) { Caption = 'recommendedPriceAuUsdStk'; }
                field(campaignPriceAuUsdStk; CampaignPriceAuUsdStk) { Caption = 'campaignPriceAuUsdStk'; }
                field(priceAusLcyStk; PriceAusLcyStk) { Caption = 'priceAusLcyStk'; }
                field(recommendedPriceAusLcyStk; RecommendedPriceAusLcyStk) { Caption = 'recommendedPriceAusLcyStk'; }
                field(campaignPriceAusLcyStk; CampaignPriceAusLcyStk) { Caption = 'campaignPriceAusLcyStk'; }
                field(priceDkLcyStk; PriceDkLcyStk) { Caption = 'priceDkLcyStk'; }
                field(recommendedPriceDkLcyStk; RecommendedPriceDkLcyStk) { Caption = 'recommendedPriceDkLcyStk'; }
                field(campaignPriceDkLcyStk; CampaignPriceDkLcyStk) { Caption = 'campaignPriceDkLcyStk'; }
                field(priceExpEurBase; PriceExpEurBase) { Caption = 'priceExpEurBase'; }
                field(recommendedPriceExpEurBase; RecommendedPriceExpEurBase) { Caption = 'recommendedPriceExpEurBase'; }
                field(campaignPriceExpEurBase; CampaignPriceExpEurBase) { Caption = 'campaignPriceExpEurBase'; }
                field(priceExpEurStk; PriceExpEurStk) { Caption = 'priceExpEurStk'; }
                field(recommendedPriceExpEurStk; RecommendedPriceExpEurStk) { Caption = 'recommendedPriceExpEurStk'; }
                field(campaignPriceExpEurStk; CampaignPriceExpEurStk) { Caption = 'campaignPriceExpEurStk'; }
                field(priceFobUsdStk; PriceFobUsdStk) { Caption = 'priceFobUsdStk'; }
                field(recommendedPriceFobUsdStk; RecommendedPriceFobUsdStk) { Caption = 'recommendedPriceFobUsdStk'; }
                field(campaignPriceFobUsdStk; CampaignPriceFobUsdStk) { Caption = 'campaignPriceFobUsdStk'; }
                field(priceIncLcyStk; PriceIncLcyStk) { Caption = 'priceIncLcyStk'; }
                field(recommendedPriceIncLcyStk; RecommendedPriceIncLcyStk) { Caption = 'recommendedPriceIncLcyStk'; }
                field(campaignPriceIncLcyStk; CampaignPriceIncLcyStk) { Caption = 'campaignPriceIncLcyStk'; }
                field(priceRrpEurBase; PriceRrpEurBase) { Caption = 'priceRrpEurBase'; }
                field(recommendedPriceRrpEurBase; RecommendedPriceRrpEurBase) { Caption = 'recommendedPriceRrpEurBase'; }
                field(campaignPriceRrpEurBase; CampaignPriceRrpEurBase) { Caption = 'campaignPriceRrpEurBase'; }
                field(priceRrpEurStk; PriceRrpEurStk) { Caption = 'priceRrpEurStk'; }
                field(recommendedPriceRrpEurStk; RecommendedPriceRrpEurStk) { Caption = 'recommendedPriceRrpEurStk'; }
                field(campaignPriceRrpEurStk; CampaignPriceRrpEurStk) { Caption = 'campaignPriceRrpEurStk'; }
                field(priceSaUsdStk; PriceSaUsdStk) { Caption = 'priceSaUsdStk'; }
                field(recommendedPriceSaUsdStk; RecommendedPriceSaUsdStk) { Caption = 'recommendedPriceSaUsdStk'; }
                field(campaignPriceSaUsdStk; CampaignPriceSaUsdStk) { Caption = 'campaignPriceSaUsdStk'; }
                field(priceSapEurStk; PriceSapEurStk) { Caption = 'priceSapEurStk'; }
                field(recommendedPriceSapEurStk; RecommendedPriceSapEurStk) { Caption = 'recommendedPriceSapEurStk'; }
                field(campaignPriceSapEurStk; CampaignPriceSapEurStk) { Caption = 'campaignPriceSapEurStk'; }
                field(priceVgrowUsdStk; PriceVgrowUsdStk) { Caption = 'priceVgrowUsdStk'; }
                field(recommendedPriceVgrowUsdStk; RecommendedPriceVgrowUsdStk) { Caption = 'recommendedPriceVgrowUsdStk'; }
                field(campaignPriceVgrowUsdStk; CampaignPriceVgrowUsdStk) { Caption = 'campaignPriceVgrowUsdStk'; }
                field(priceWebDeEurStk_DE; PriceWebDeEurStk_DE) { Caption = 'priceWebDeEurStk_DE'; }
                field(recommendedPriceWebDeEurStk_DE; RecommendedPriceWebDeEurStk_DE) { Caption = 'recommendedPriceWebDeEurStk_DE'; }
                field(campaignPriceWebDeEurStk_DE; CampaignPriceWebDeEurStk_DE) { Caption = 'campaignPriceWebDeEurStk_DE'; }
                field(priceWebDkLcyStk_DK; PriceWebDkLcyStk_DK) { Caption = 'priceWebDkLcyStk_DK'; }
                field(recommendedPriceWebDkLcyStk_DK; RecommendedPriceWebDkLcyStk_DK) { Caption = 'recommendedPriceWebDkLcyStk_DK'; }
                field(campaignPriceWebDkLcyStk_DK; CampaignPriceWebDkLcyStk_DK) { Caption = 'campaignPriceWebDkLcyStk_DK'; }
                field(priceWebNlEurStk_NL; PriceWebNlEurStk_NL) { Caption = 'priceWebNlEurStk_NL'; }
                field(recommendedPriceWebNlEurStk_NL; RecommendedPriceWebNlEurStk_NL) { Caption = 'recommendedPriceWebNlEurStk_NL'; }
                field(campaignPriceWebNlEurStk_NL; CampaignPriceWebNlEurStk_NL) { Caption = 'campaignPriceWebNlEurStk_NL'; }
                field(priceWebNoLcyStk_NO; PriceWebNoLcyStk_NO) { Caption = 'priceWebNoLcyStk_NO'; }
                field(recommendedPriceWebNoLcyStk_NO; RecommendedPriceWebNoLcyStk_NO) { Caption = 'recommendedPriceWebNoLcyStk_NO'; }
                field(campaignPriceWebNoLcyStk_NO; CampaignPriceWebNoLcyStk_NO) { Caption = 'campaignPriceWebNoLcyStk_NO'; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        BuildItemRowsForToday();
        Rec.Reset();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPriceFieldsForItem(Rec."Asset No.");
    end;

    var
        PriceAmazonDeEurStk: Decimal;
        RecommendedPriceAmazonDeEurStk: Decimal;
        CampaignPriceAmazonDeEurStk: Decimal;
        PriceAmazonEsEurStk: Decimal;
        RecommendedPriceAmazonEsEurStk: Decimal;
        CampaignPriceAmazonEsEurStk: Decimal;
        PriceAuUsdBase: Decimal;
        RecommendedPriceAuUsdBase: Decimal;
        CampaignPriceAuUsdBase: Decimal;
        PriceAuUsdCdu: Decimal;
        RecommendedPriceAuUsdCdu: Decimal;
        CampaignPriceAuUsdCdu: Decimal;
        PriceAuUsdStk: Decimal;
        RecommendedPriceAuUsdStk: Decimal;
        CampaignPriceAuUsdStk: Decimal;
        PriceAusLcyStk: Decimal;
        RecommendedPriceAusLcyStk: Decimal;
        CampaignPriceAusLcyStk: Decimal;
        PriceDkLcyStk: Decimal;
        RecommendedPriceDkLcyStk: Decimal;
        CampaignPriceDkLcyStk: Decimal;
        PriceExpEurBase: Decimal;
        RecommendedPriceExpEurBase: Decimal;
        CampaignPriceExpEurBase: Decimal;
        PriceExpEurStk: Decimal;
        RecommendedPriceExpEurStk: Decimal;
        CampaignPriceExpEurStk: Decimal;
        PriceFobUsdStk: Decimal;
        RecommendedPriceFobUsdStk: Decimal;
        CampaignPriceFobUsdStk: Decimal;
        PriceIncLcyStk: Decimal;
        RecommendedPriceIncLcyStk: Decimal;
        CampaignPriceIncLcyStk: Decimal;
        PriceRrpEurBase: Decimal;
        RecommendedPriceRrpEurBase: Decimal;
        CampaignPriceRrpEurBase: Decimal;
        PriceRrpEurStk: Decimal;
        RecommendedPriceRrpEurStk: Decimal;
        CampaignPriceRrpEurStk: Decimal;
        PriceSaUsdStk: Decimal;
        RecommendedPriceSaUsdStk: Decimal;
        CampaignPriceSaUsdStk: Decimal;
        PriceSapEurStk: Decimal;
        RecommendedPriceSapEurStk: Decimal;
        CampaignPriceSapEurStk: Decimal;
        PriceVgrowUsdStk: Decimal;
        RecommendedPriceVgrowUsdStk: Decimal;
        CampaignPriceVgrowUsdStk: Decimal;
        PriceWebDeEurStk_DE: Decimal;
        RecommendedPriceWebDeEurStk_DE: Decimal;
        CampaignPriceWebDeEurStk_DE: Decimal;
        PriceWebDkLcyStk_DK: Decimal;
        RecommendedPriceWebDkLcyStk_DK: Decimal;
        CampaignPriceWebDkLcyStk_DK: Decimal;
        PriceWebNlEurStk_NL: Decimal;
        RecommendedPriceWebNlEurStk_NL: Decimal;
        CampaignPriceWebNlEurStk_NL: Decimal;
        PriceWebNoLcyStk_NO: Decimal;
        RecommendedPriceWebNoLcyStk_NO: Decimal;
        CampaignPriceWebNoLcyStk_NO: Decimal;

    local procedure BuildItemRowsForToday()
    var
        FilterItemNo: Text;
    begin
        FilterItemNo := Rec.GetFilter("Asset No.");

        Rec.Reset();
        Rec.DeleteAll();

        AddCurrentCompanyItemRows(FilterItemNo);
        AddNorwayCompanyItemRows(FilterItemNo);
    end;

    local procedure AddCurrentCompanyItemRows(FilterItemNo: Text)
    var
        PriceLine: Record "Price List Line";
        Existing: Record "Price List Line" temporary;
    begin
        ApplyItemRowFilters(PriceLine, FilterItemNo);

        if PriceLine.FindSet() then
            repeat
                if IsCurrentCompanyPriceCombination(PriceLine."Source No.", GetExportCurrencyCode(PriceLine."Currency Code"), PriceLine."Unit of Measure Code") then begin
                    Existing.Reset();
                    Existing.Copy(Rec, true);
                    Existing.SetRange("Asset No.", PriceLine."Asset No.");

                    if not Existing.FindFirst() then begin
                        Rec := PriceLine;
                        Rec.Insert();
                    end else
                        if IsBetterPriceLine(PriceLine, Existing) then begin
                            Rec.Reset();
                            Rec.SetRange(SystemId, Existing.SystemId);
                            if Rec.FindFirst() then
                                Rec.Delete();

                            Rec := PriceLine;
                            Rec.Insert();
                        end;
                end;
            until PriceLine.Next() = 0;
    end;

    local procedure AddNorwayCompanyItemRows(FilterItemNo: Text)
    var
        PriceLine: Record "Price List Line";
        Existing: Record "Price List Line" temporary;
    begin
        ChangePriceListLineCompany(PriceLine, GetNorwayCompanyName());
        ApplyItemRowFilters(PriceLine, FilterItemNo);

        if PriceLine.FindSet() then
            repeat
                if IsNorwayCompanyPriceCombination(PriceLine."Source No.", GetExportCurrencyCode(PriceLine."Currency Code"), PriceLine."Unit of Measure Code") then begin
                    Existing.Reset();
                    Existing.Copy(Rec, true);
                    Existing.SetRange("Asset No.", PriceLine."Asset No.");

                    if not Existing.FindFirst() then begin
                        Rec := PriceLine;
                        Rec.Insert();
                    end;
                end;
            until PriceLine.Next() = 0;
    end;

    local procedure ApplyItemRowFilters(var PriceLine: Record "Price List Line"; FilterItemNo: Text)
    begin
        PriceLine.Reset();
        PriceLine.SetRange("Asset Type", PriceLine."Asset Type"::Item);
        PriceLine.SetRange("Source Type", PriceLine."Source Type"::"Customer Price Group");
        PriceLine.SetRange(Status, PriceLine.Status::Active);
        PriceLine.SetFilter("Starting Date", '..%1', Today);
        PriceLine.SetFilter("Ending Date", '%1..|%2', Today, 0D);

        if FilterItemNo <> '' then
            PriceLine.SetFilter("Asset No.", FilterItemNo);
    end;

    local procedure SetPriceFieldsForItem(ItemNo: Code[20])
    begin
        SetPriceSet(ItemNo, 'AMAZON.DE', 'EUR', 'STK', '', PriceAmazonDeEurStk, RecommendedPriceAmazonDeEurStk, CampaignPriceAmazonDeEurStk);
        SetPriceSet(ItemNo, 'AMAZON.ES', 'EUR', 'STK', '', PriceAmazonEsEurStk, RecommendedPriceAmazonEsEurStk, CampaignPriceAmazonEsEurStk);
        SetPriceSet(ItemNo, 'AU', 'USD', 'BASE', '', PriceAuUsdBase, RecommendedPriceAuUsdBase, CampaignPriceAuUsdBase);
        SetPriceSet(ItemNo, 'AU', 'USD', 'CDU', '', PriceAuUsdCdu, RecommendedPriceAuUsdCdu, CampaignPriceAuUsdCdu);
        SetPriceSet(ItemNo, 'AU', 'USD', 'STK', '', PriceAuUsdStk, RecommendedPriceAuUsdStk, CampaignPriceAuUsdStk);
        SetPriceSet(ItemNo, 'AUS', 'LCY', 'STK', '', PriceAusLcyStk, RecommendedPriceAusLcyStk, CampaignPriceAusLcyStk);
        SetPriceSet(ItemNo, 'DK', 'LCY', 'STK', '', PriceDkLcyStk, RecommendedPriceDkLcyStk, CampaignPriceDkLcyStk);
        SetPriceSet(ItemNo, 'EXP', 'EUR', 'BASE', '', PriceExpEurBase, RecommendedPriceExpEurBase, CampaignPriceExpEurBase);
        SetPriceSet(ItemNo, 'EXP', 'EUR', 'STK', '', PriceExpEurStk, RecommendedPriceExpEurStk, CampaignPriceExpEurStk);
        SetPriceSet(ItemNo, 'FOB', 'USD', 'STK', '', PriceFobUsdStk, RecommendedPriceFobUsdStk, CampaignPriceFobUsdStk);
        SetPriceSet(ItemNo, 'INC', 'LCY', 'STK', '', PriceIncLcyStk, RecommendedPriceIncLcyStk, CampaignPriceIncLcyStk);
        SetPriceSet(ItemNo, 'RRP', 'EUR', 'BASE', '', PriceRrpEurBase, RecommendedPriceRrpEurBase, CampaignPriceRrpEurBase);
        SetPriceSet(ItemNo, 'RRP', 'EUR', 'STK', '', PriceRrpEurStk, RecommendedPriceRrpEurStk, CampaignPriceRrpEurStk);
        SetPriceSet(ItemNo, 'SA', 'USD', 'STK', '', PriceSaUsdStk, RecommendedPriceSaUsdStk, CampaignPriceSaUsdStk);
        SetPriceSet(ItemNo, 'SAP', 'EUR', 'STK', '', PriceSapEurStk, RecommendedPriceSapEurStk, CampaignPriceSapEurStk);
        SetPriceSet(ItemNo, 'VGROW', 'USD', 'STK', '', PriceVgrowUsdStk, RecommendedPriceVgrowUsdStk, CampaignPriceVgrowUsdStk);
        SetPriceSet(ItemNo, 'WEB-DE', 'EUR', 'STK', '', PriceWebDeEurStk_DE, RecommendedPriceWebDeEurStk_DE, CampaignPriceWebDeEurStk_DE);
        SetPriceSet(ItemNo, 'WEB-DK', 'LCY', 'STK', '', PriceWebDkLcyStk_DK, RecommendedPriceWebDkLcyStk_DK, CampaignPriceWebDkLcyStk_DK);
        SetPriceSet(ItemNo, 'WEB_NL', 'EUR', 'STK', '', PriceWebNlEurStk_NL, RecommendedPriceWebNlEurStk_NL, CampaignPriceWebNlEurStk_NL);
        SetPriceSet(ItemNo, 'WEB_NO', 'LCY', 'STK', GetNorwayCompanyName(), PriceWebNoLcyStk_NO, RecommendedPriceWebNoLcyStk_NO, CampaignPriceWebNoLcyStk_NO);
    end;

    local procedure SetPriceSet(ItemNo: Code[20]; SourceNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]; CompanyName: Text[30]; var PriceValue: Decimal; var RecommendedPriceValue: Decimal; var CampaignPriceValue: Decimal)
    begin
        PriceValue := 0;
        RecommendedPriceValue := 0;
        CampaignPriceValue := 0;

        TryGetPreferredCustomerPrice(ItemNo, SourceNo, CurrencyCode, UoMCode, CompanyName, Today, PriceValue, RecommendedPriceValue);
        TryGetBestCampaignPrice(ItemNo, SourceNo, CurrencyCode, UoMCode, CompanyName, Today, CampaignPriceValue);
    end;

    local procedure TryGetPreferredCustomerPrice(ItemNo: Code[20]; SourceNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]; CompanyName: Text[30]; AsOfDate: Date; var PriceValue: Decimal; var RecommendedPriceValue: Decimal): Boolean
    var
        PriceLine: Record "Price List Line";
        BestPriceLine: Record "Price List Line";
        Found: Boolean;
    begin
        ChangePriceListLineCompany(PriceLine, CompanyName);
        ApplyCommonPriceFilters(PriceLine, ItemNo, CurrencyCode, UoMCode, AsOfDate);
        PriceLine.SetRange("Source Type", PriceLine."Source Type"::"Customer Price Group");
        PriceLine.SetRange("Source No.", SourceNo);

        if PriceLine.FindSet() then
            repeat
                if (not Found) or IsBetterPriceLine(PriceLine, BestPriceLine) then begin
                    BestPriceLine := PriceLine;
                    Found := true;
                end;
            until PriceLine.Next() = 0;

        if Found then begin
            PriceValue := BestPriceLine."Unit Price";
            RecommendedPriceValue := GetNotoUnitListPrice(BestPriceLine);
        end;

        exit(Found);
    end;

    local procedure TryGetBestCampaignPrice(ItemNo: Code[20]; SourceNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]; CompanyName: Text[30]; AsOfDate: Date; var CampaignPriceValue: Decimal): Boolean
    var
        CampaignPriceLine: Record "Price List Line";
        BestCampaignPriceLine: Record "Price List Line";
        Campaign: Record Campaign;
        Found: Boolean;
    begin
        ChangePriceListLineCompany(CampaignPriceLine, CompanyName);
        ChangeCampaignCompany(Campaign, CompanyName);
        ApplyCommonPriceFilters(CampaignPriceLine, ItemNo, CurrencyCode, UoMCode, AsOfDate);
        CampaignPriceLine.SetRange("Source Type", CampaignPriceLine."Source Type"::Campaign);

        if CampaignPriceLine.FindSet() then
            repeat
                if Campaign.Get(CampaignPriceLine."Source No.") then
                    if GetNotoCampaignCustomerPriceGroup(Campaign) = SourceNo then
                        if (not Found) or IsBetterPriceLine(CampaignPriceLine, BestCampaignPriceLine) then begin
                            BestCampaignPriceLine := CampaignPriceLine;
                            Found := true;
                        end;
            until CampaignPriceLine.Next() = 0;

        if Found then
            CampaignPriceValue := BestCampaignPriceLine."Unit Price";

        exit(Found);
    end;

    local procedure ApplyCommonPriceFilters(var PriceLine: Record "Price List Line"; ItemNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]; AsOfDate: Date)
    begin
        PriceLine.Reset();
        PriceLine.SetRange("Asset Type", PriceLine."Asset Type"::Item);
        PriceLine.SetRange("Asset No.", ItemNo);
        PriceLine.SetRange(Status, PriceLine.Status::Active);
        PriceLine.SetFilter("Starting Date", '..%1', AsOfDate);
        PriceLine.SetFilter("Ending Date", '%1..|%2', AsOfDate, 0D);
        SetCurrencyCodeFilter(PriceLine, CurrencyCode);
        PriceLine.SetRange("Unit of Measure Code", UoMCode);
    end;

    local procedure SetCurrencyCodeFilter(var PriceLine: Record "Price List Line"; CurrencyCode: Code[10])
    begin
        if CurrencyCode = 'LCY' then begin
            PriceLine.SetRange("Currency Code", '');
            exit;
        end;

        PriceLine.SetRange("Currency Code", CurrencyCode);
    end;

    local procedure IsBetterPriceLine(Candidate: Record "Price List Line"; Existing: Record "Price List Line"): Boolean
    begin
        if Candidate."Minimum Quantity" <> Existing."Minimum Quantity" then
            exit(Candidate."Minimum Quantity" < Existing."Minimum Quantity");

        if Candidate."Starting Date" <> Existing."Starting Date" then
            exit(Candidate."Starting Date" > Existing."Starting Date");

        if Existing."Unit Price" = 0 then
            exit(Candidate."Unit Price" <> 0);
        if Candidate."Unit Price" = 0 then
            exit(false);

        exit(Candidate."Unit Price" < Existing."Unit Price");
    end;

    local procedure IsCurrentCompanyPriceCombination(SourceNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]): Boolean
    begin
        case SourceNo of
            'AMAZON.DE':
                exit((CurrencyCode = 'EUR') and (UoMCode = 'STK'));
            'AMAZON.ES':
                exit((CurrencyCode = 'EUR') and (UoMCode = 'STK'));
            'AU':
                exit((CurrencyCode = 'USD') and (UoMCode in ['BASE', 'CDU', 'STK']));
            'AUS':
                exit((CurrencyCode = 'LCY') and (UoMCode = 'STK'));
            'DK':
                exit((CurrencyCode = 'LCY') and (UoMCode = 'STK'));
            'EXP':
                exit((CurrencyCode = 'EUR') and (UoMCode in ['BASE', 'STK']));
            'FOB':
                exit((CurrencyCode = 'USD') and (UoMCode = 'STK'));
            'INC':
                exit((CurrencyCode = 'LCY') and (UoMCode = 'STK'));
            'RRP':
                exit((CurrencyCode = 'EUR') and (UoMCode in ['BASE', 'STK']));
            'SA':
                exit((CurrencyCode = 'USD') and (UoMCode = 'STK'));
            'SAP':
                exit((CurrencyCode = 'EUR') and (UoMCode = 'STK'));
            'VGROW':
                exit((CurrencyCode = 'USD') and (UoMCode = 'STK'));
            'WEB-DE':
                exit((CurrencyCode = 'EUR') and (UoMCode = 'STK'));
            'WEB-DK':
                exit((CurrencyCode = 'LCY') and (UoMCode = 'STK'));
            'WEB_NL':
                exit((CurrencyCode = 'EUR') and (UoMCode = 'STK'));
        end;

        exit(false);
    end;

    local procedure IsNorwayCompanyPriceCombination(SourceNo: Code[20]; CurrencyCode: Code[10]; UoMCode: Code[10]): Boolean
    begin
        case SourceNo of
            'WEB_NO':
                exit((CurrencyCode = 'LCY') and (UoMCode = 'STK'));
        end;

        exit(false);
    end;

    local procedure ChangePriceListLineCompany(var PriceLine: Record "Price List Line"; CompanyName: Text[30])
    begin
        if CompanyName = '' then
            exit;

        if not PriceLine.ChangeCompany(CompanyName) then
            Error('Could not change Price List Line company to %1.', CompanyName);
    end;

    local procedure ChangeCampaignCompany(var Campaign: Record Campaign; CompanyName: Text[30])
    begin
        if CompanyName = '' then
            exit;

        if not Campaign.ChangeCompany(CompanyName) then
            Error('Could not change Campaign company to %1.', CompanyName);
    end;

    local procedure GetNotoUnitListPrice(PriceLine: Record "Price List Line"): Decimal
    var
        PriceLineRecordRef: RecordRef;
        UnitListPriceFieldRef: FieldRef;
        UnitListPrice: Decimal;
    begin
        PriceLineRecordRef.GetTable(PriceLine);
        if not PriceLineRecordRef.FieldExist(51003) then
            Error('Price List Line field 51003 is required for Perfion recommended price output. Install the KOLLAB/NOTO price list extension.');

        UnitListPriceFieldRef := PriceLineRecordRef.Field(51003);
        UnitListPrice := UnitListPriceFieldRef.Value();

        exit(UnitListPrice);
    end;

    local procedure GetNotoCampaignCustomerPriceGroup(Campaign: Record Campaign): Code[20]
    var
        CampaignRecordRef: RecordRef;
        CustomerPriceGroupFieldRef: FieldRef;
        CustomerPriceGroup: Code[20];
    begin
        CampaignRecordRef.GetTable(Campaign);
        if not CampaignRecordRef.FieldExist(51001) then
            Error('Campaign field 51001 is required for Perfion campaign price matching. Install the KOLLAB/NOTO campaign extension.');

        CustomerPriceGroupFieldRef := CampaignRecordRef.Field(51001);
        CustomerPriceGroup := CustomerPriceGroupFieldRef.Value();

        exit(CustomerPriceGroup);
    end;

    local procedure GetExportCurrencyCode(CurrencyCode: Code[10]): Code[10]
    begin
        if CurrencyCode = '' then
            exit('LCY');

        exit(CurrencyCode);
    end;

    local procedure GetNorwayCompanyName(): Text[30]
    begin
        exit('SCANPAN Norge');
    end;
}
